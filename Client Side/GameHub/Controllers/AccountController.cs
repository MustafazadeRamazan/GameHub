using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameHub.Models;
using System.Data;
using System.Net;
using System.Net.Mail;


namespace GameHub.Controllers
{
    public class AccountController : Controller
    {
        GameHubEntities db = new GameHubEntities();
        string senderEmail = ""; // Update with your email address
        string senderPassword = ""; // Update with your email password

        public ActionResult Index()
        {
            this.GetDefaultData();

            var usr = db.Customers.Find(TempShpData.UserID);
            return View(usr);

        }


        [HttpPost]
        public ActionResult Register(Customer cust)
        {
            if (ModelState.IsValid)
            {
                string[] usernames = { cust.UserName };

                if (cust.UserName.Contains(' '))
                {
                    usernames = cust.UserName.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                }

                bool isEmailExists = IsEmailExists(cust.Email);

                foreach (string username in usernames)
                {
                    if (IsUsernameExists(username))
                    {
                        TempData["AlertMessageError"] = "Username already exists. Please choose a different username.";
                        return RedirectToAction("Login", "Account");
                    }
                }

                if (isEmailExists)
                {
                    TempData["AlertMessageError"] = "Email already exists. Please choose a different email.";
                    return RedirectToAction("Login", "Account");
                }

                string verificationToken = Guid.NewGuid().ToString();

                foreach (string username in usernames)
                {
                    Customer customer = new Customer
                    {
                        First_Name = cust.First_Name,
                        Last_Name = cust.Last_Name,
                        UserName = username,
                        Age = cust.Age,
                        Email = cust.Email,
                        Password = cust.Password,
                        Mobile1 = cust.Mobile1,
                        Country = cust.Country,
                        Organization = verificationToken
                    };

                    SendVerificationEmail(customer, verificationToken);

                    db.Customers.Add(customer);
                    db.SaveChanges();
                    TempData["AlertMessageSuccess"] = $"Email verification code sent to {cust.Email}, please confirm to login";
                    break;
                }

                return RedirectToAction("Login", "Account");
            }

            return View();
        }

        private void SendVerificationEmail(Customer customer, string verificationToken)
        {
            string emailSubject = "Account Verification";

            MailMessage mailMessage = new MailMessage(senderEmail, customer.Email)
            {
                Subject = emailSubject,
                IsBodyHtml = true
            };
            mailMessage.Body = "<h2>" + "Hi <strong>" + customer.UserName + "</strong>," + "</h2>" +
                        "<br>" +
                        "<h3>" + "Thank you for joining the GameHub family, click the link below to verify your account" + "</h3>" +
                        "<br>" +
                        $"<h3>Please click the following link to verify your account: {Url.Action("VerifyEmail", "Account", new { token = verificationToken }, Request.Url.Scheme)}</h3>" +
                        "<br>";
            mailMessage.Body += "<br>Best regards,<br><strong>GameHub Support</strong>";

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com")
            {
                Port = 587,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(senderEmail, senderPassword),
                EnableSsl = true
            };

            try
            {
                smtpClient.Send(mailMessage);
            }
            catch (Exception)
            {
                TempData["AlertMessageError"] = "Something went wrong, please try again.";
            }
        }

        public ActionResult VerifyEmail(string token)
        {
            Customer customer = db.Customers.FirstOrDefault(c => c.Organization == token);

            if (customer != null)
            {
                customer.status = "Verified";
                customer.Organization = null;

                db.SaveChanges();

                Session["username"] = customer.UserName;
                TempShpData.UserID = customer.CustomerID;
                TempData["AlertMessageSuccess"] = $"{customer.First_Name} Successfully registered!";
            }
            else
            {
                TempData["AlertMessageError"] = "Invalid verification token. Please check your email or request a new verification link.";
            }

            return RedirectToAction("Index", "Home");
        }

        public ActionResult ForgotPassword(string email)
        {
            Customer customer = db.Customers.FirstOrDefault(c => c.Email == email);

            if (customer != null)
            {
                string newPassword = GenerateRandomPassword();

                customer.Password = newPassword;

                db.SaveChanges();
                SendNewPasswordEmail(customer, newPassword);

                TempData["AlertMessageSuccess"] = "A new password has been sent to your email address.";
            }
            else
            {
                TempData["AlertMessageError"] = "Invalid email address. Please check your input or contact support.";
            }

            return RedirectToAction("Login", "Account");
        }

        private string GenerateRandomPassword()
        {
            const string allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            Random random = new Random();
            string newPassword = new string(
                Enumerable.Repeat(allowedChars, 8)
                          .Select(s => s[random.Next(s.Length)])
                          .ToArray());

            return newPassword;
        }

        private void SendNewPasswordEmail(Customer customer, string newPassword)
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(senderEmail);
            mail.To.Add(customer.Email);
            mail.Subject = "New Password";
            mail.IsBodyHtml = true;
            mail.Body = "<h2>" + "Hi <strong>" + customer.UserName + "</strong>," + "</h2>" +
                        "<br>" +
                        "<h2>" + "Please don't share your password with others!" + "</h2>" +
                        "<br>" +
                        "<h1>Your new password is: <strong style=\"color: green;\">" + newPassword + "</strong></h1>" +
                        "<br>";
            mail.Body += $"<br><br>Best regards,<br><strong>GameHub Support</strong>";

            using (SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587))
            {
                smtpClient.Credentials = new NetworkCredential(senderEmail, senderPassword);
                smtpClient.EnableSsl = true;
                try
                {
                    smtpClient.Send(mail);
                }
                catch (Exception)
                {
                    TempData["AlertMessageError"] = "Something went wrong, please try again.";
                }
            }
        }



        private bool IsUsernameExists(string username)
        {
            var customers = db.Customers.ToList();
            foreach (var customer in customers)
            {
                if (customer.UserName == username)
                {
                    return true;
                }
            }
            return false;
        }

        private bool IsEmailExists(string email)
        {
            var customers = db.Customers.ToList();
            foreach (var customer in customers)
            {
                if (customer.Email == email)
                {
                    return true;
                }
            }
            return false;
        }


        public ActionResult Login()
        {
            return View();
        }

         [HttpPost]
        public ActionResult Login(FormCollection formColl)
        {
            string usrName = formColl["UserName"];
            string Pass = formColl["Password"];

            if (ModelState.IsValid)
            {
                var cust = (from m in db.Customers
                            where (m.UserName == usrName && m.Password == Pass)
                            select m).SingleOrDefault();

                if (cust != null && cust.status == "Verified")
                {
                    TempShpData.UserID = cust.CustomerID;
                    Session["username"] = cust.UserName;
                    TempData["AlertMessageSuccess"] = $"{cust.First_Name} Welcome back!";
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    TempData["AlertMessageErrorLogin"] = "Username Or Password wrong.";
                }
                      
            }
            return View();
        }

         public ActionResult Logout()
         {
             Session["username"] = null;
             TempShpData.UserID = 0;
             TempShpData.items = null;
            TempData["AlertMessageSuccess"] = "Successfully Logged Out!";
            return RedirectToAction("Index", "Home");
         }

       

        public Customer GetUser(string _usrName)
        {
            var cust = (from c in db.Customers
                        where c.UserName == _usrName
                        select c).FirstOrDefault();
            return cust;
        }

        [HttpPost]
        public ActionResult Update(Customer cust)
        {
            if (ModelState.IsValid)
            {
                Customer existingCustomer = db.Customers.Find(cust.CustomerID);

                if (existingCustomer.Email != cust.Email && IsEmailExists(cust.Email))
                {
                    TempData["AlertMessageError"] = "Email already exists. Please choose a different email.";
                    return RedirectToAction("Index", "Home");
                }

                string[] newUsername = cust.UserName.Split(' ');

                if (!string.Equals(existingCustomer.UserName, cust.UserName, StringComparison.OrdinalIgnoreCase) && IsAnyUsernameExists(newUsername))
                {
                    TempData["AlertMessageError"] = "Username already exists. Please choose a different username.";
                    return RedirectToAction("Index", "Home");
                }

                existingCustomer.First_Name = cust.First_Name;
                existingCustomer.Last_Name = cust.Last_Name;
                existingCustomer.UserName = cust.UserName;
                existingCustomer.Age = cust.Age;
                existingCustomer.Picture = cust.Picture;
                existingCustomer.State = cust.State;
                existingCustomer.City = cust.City;
                existingCustomer.PostalCode = cust.PostalCode;
                existingCustomer.Address1 = cust.Address1;
                existingCustomer.Email = cust.Email;
                existingCustomer.Password = cust.Password;
                existingCustomer.Mobile1 = cust.Mobile1;
                existingCustomer.Country = cust.Country;

                db.Entry(existingCustomer).State = EntityState.Modified;
                db.SaveChanges();

                Session["username"] = cust.UserName;
                TempData["AlertMessageSuccess"] = $"Profile Updated Successfully";

                return RedirectToAction("Index", "Home");
            }

            return View();
        }

        private bool IsAnyUsernameExists(string[] usernames)
        {
            foreach (string username in usernames)
            {
                if (IsUsernameExists(username))
                {
                    return true;
                }
            }

            return false;
        }

        public ActionResult SessionExpired()
        {
            Session.Clear();
            TempData["AlertMessageError"] = "Session Expired, please login again";
            return RedirectToAction("Login", "Account");
        }


    }
}