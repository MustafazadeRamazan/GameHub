using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameHub.Models;
using System.Data;

namespace GameHub.Controllers
{
    public class AccountController : Controller
    {
        GameHubEntities db = new GameHubEntities();

        // GET: Account
        public ActionResult Index()
        {
            this.GetDefaultData();

            var usr = db.Customers.Find(TempShpData.UserID);
            return View(usr);

        }


        //REGISTER CUSTOMER
        [HttpPost]
        public ActionResult Register(Customer cust)
        {
            if (ModelState.IsValid)
            {
                string[] usernames = { cust.UserName }; // Assign the original username to the array

                if (cust.UserName.Contains(' '))
                {
                    usernames = cust.UserName.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries); // Split the username if it contains a space
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
                        Country = cust.Country
                    };

                    db.Customers.Add(customer);
                    db.SaveChanges();

                    Session["username"] = username;
                    TempShpData.UserID = GetUser(username).CustomerID;
                    TempData["AlertMessageSuccess"] = $"{cust.First_Name} Successfully registered!";
                    break;
                }

                return RedirectToAction("Index", "Home");
            }

            return View();
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




        //LOG IN
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

                if (cust !=null )
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

        //LOG OUT
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

        //UPDATE CUSTOMER DATA
        [HttpPost]
        public ActionResult Update(Customer cust)
        {
            if (ModelState.IsValid)
            {
                Customer existingCustomer = db.Customers.Find(cust.CustomerID);

                // Check if the provided email already exists in the database, excluding the case where the email belongs to the current customer being updated.
                if (existingCustomer.Email != cust.Email && IsEmailExists(cust.Email))
                {
                    TempData["AlertMessageError"] = "Email already exists. Please choose a different email.";
                    return RedirectToAction("Index", "Home");
                }

                // Split the new username by space if necessary
                string[] newUsername = cust.UserName.Split(' ');

                // If the username is changed, check if the new username(s) already exist.
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