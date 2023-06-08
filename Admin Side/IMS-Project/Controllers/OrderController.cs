using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using IMS_Project.Models;

namespace IMS_Project.Controllers
{
    public class OrderController : Controller
    {
        GameHubEntities db = new GameHubEntities();
        string senderEmail = "your-email@gmail.com"; // Update with your email address
        string senderPassword = "your-password"; // Update with your email password
        public ActionResult Index()
        {
            return View(db.Orders.OrderByDescending(x => x.OrderID).ToList());
        }
        public ActionResult Details(int id)
        {
            Order ord = db.Orders.Find(id);
            var Ord_details = db.OrderDetails.Where(x => x.OrderID == id).ToList();
            var tuple = new Tuple<Order, IEnumerable<OrderDetail>>(ord, Ord_details);

            double SumAmount = Convert.ToDouble(Ord_details.Sum(x => x.TotalAmount));
            ViewBag.TotalItems = Ord_details.Sum(x => x.Quantity);
            ViewBag.Discount = 0;
            ViewBag.TAmount = SumAmount - 0;
            ViewBag.Amount = SumAmount;
            ViewBag.ShowCancelButton = true;

            if (ord.CancelOrder == true)
            {
                ViewBag.ShowFinishButton = false;
                ViewBag.ShowDispatchButton = false;
                ViewBag.ShowCancelButton = false;
            }

            if (ord.CancelOrder == false)
            {
                if (ord.DIspatched == false)
                {
                    ViewBag.ShowDispatchButton = true;
                }
                else
                {
                    ViewBag.ShowDispatchButton = false;
                    ViewBag.ShowCancelButton = false;
                }

                if (ord.DIspatched == true && ord.Deliver == false)
                {
                    ViewBag.ShowFinishButton = true;
                }
                else
                {
                    ViewBag.ShowFinishButton = false;
                }
            }

            return View(tuple);
        }

        public ActionResult Dispatch(int id)
        {
            Order ord = db.Orders.Find(id);
            ord.DispatchedDate = DateTime.Now;
            ord.DIspatched = true;
            db.SaveChanges();

            var customer = db.Customers.Find(ord.CustomerID);
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(senderEmail);
            mail.To.Add(customer.Email);
            mail.Subject = $"Order ID: {ord.OrderID} Dispatched ✔";
            mail.IsBodyHtml = true;
            mail.Body = "Hi <strong>" + customer.UserName + "</strong>," +
                        "<br><br>" +
                        "<strong style =\"color: #c29100;\">" + "Your order has been sent, if you have accepted it, please complete the order ⌛" + "</strong>" +
                        "<br>" +
                        "Order ID: <strong>" + ord.OrderID + "</strong>" +
                        "<br>" +
                        "Order Dispatched : <strong style=\"color: green;\">✔</strong>" +
                        "<br>" +
                        "Order Finished : <strong>✖</strong>" +
                        "<br>" +
                        "Your Name : <strong>" + customer.First_Name + "</strong>" +
                        "<br>" +
                        "Your Surname : <strong>" + customer.Last_Name + "</strong>" +
                        "<br>" +
                        "Your Email : <strong>" + customer.Email + "</strong>" +
                        "<br>" +
                        "Your Number : <strong>" + customer.Mobile1 + "</strong>" +
                        "<br>" +
                        "Your Country : <strong>" + customer.Country + "</strong>" +
                        "<br>" +
                        "Order Date : <strong>" + ord.OrderDate + "</strong>" +
                        "<br>";
            mail.Body += $"<br><br>If you are not satisfied with your order, you can let us know about the support.<br><br>Best regards,<br><strong>GameHub Support</strong>";


            using (SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587))
            {
                smtpClient.EnableSsl = true;
                smtpClient.Credentials = new NetworkCredential(senderEmail, senderPassword);

                try
                {
                    smtpClient.Send(mail);
                }
                catch (Exception)
                {
                    TempData["AlertMessageError"] = "Something went wrong, please try again.";
                }
            }

            TempData["AlertMessageSuccess"] = $"Order ID:{ord.OrderID} Dispatched Successfully";
            return RedirectToAction("Details", new { id = ord.OrderID });
        }

        public ActionResult Finish(int id)
        {
            Order ord = db.Orders.Find(id);
            ord.DeliveryDate = DateTime.Now;
            ord.Deliver = true;
            db.SaveChanges();

            var customer = db.Customers.Find(ord.CustomerID);
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(senderEmail);
            mail.To.Add(customer.Email);
            mail.Subject = $"Order ID: {ord.OrderID} Finished ✔";
            mail.IsBodyHtml = true;
            mail.Body = "Hi <strong>" + customer.UserName + "</strong>," +
                        "<br><br>" +
                        "<strong style=\"color: green;\">" + "Your order has been completed ✔" + "</strong>" +
                        "<br>" +
                        "Order ID: <strong>" + ord.OrderID + "</strong>" +
                        "<br>" +
                        "Order Dispatched : <strong style=\"color: green;\">✔</strong>" +
                        "<br>" +
                        "Order Finished : <strong style=\"color: green;\">✔</strong>" +
                        "<br>" +
                        "Your Name : <strong>" + customer.First_Name + "</strong>" +
                        "<br>" +
                        "Your Surname : <strong>" + customer.Last_Name + "</strong>" +
                        "<br>" +
                        "Your Email : <strong>" + customer.Email + "</strong>" +
                        "<br>" +
                        "Your Number : <strong>" + customer.Mobile1 + "</strong>" +
                        "<br>" +
                        "Your Country : <strong>" + customer.Country + "</strong>" +
                        "<br>" +
                        "Order Date : <strong>" + ord.OrderDate + "</strong>" +
                        "<br>";
            mail.Body += $"<br><br>Again Thank you for shopping.If you are not satisfied with your order, you can let us know about the support.<br><br>Best regards,<br><strong>GameHub Support</strong>";


            using (SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587))
            {
                smtpClient.EnableSsl = true;
                smtpClient.Credentials = new NetworkCredential(senderEmail, senderPassword);

                try
                {
                    smtpClient.Send(mail);
                }
                catch (Exception)
                {
                    TempData["AlertMessageError"] = "Something went wrong, please try again.";
                }
            }

            TempData["AlertMessageSuccess"] = $"Order ID:{ord.OrderID} Finished Successfully";
            return RedirectToAction("Details", new { id = ord.OrderID });
        }

        public ActionResult CancelOrder(int id)
        {
            Order ord = db.Orders.Find(id);
            ord.CancelOrder = true;
            db.SaveChanges();


            var customer = db.Customers.Find(ord.CustomerID);
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(senderEmail);
            mail.To.Add(customer.Email);
            mail.Subject = $"Order ID: {ord.OrderID} Canceled ✖";
            mail.IsBodyHtml = true;
            mail.Body = "Hi <strong>" + customer.UserName + "</strong>," +
                        "<br><br>" +
                        "<strong style=\"color: red;\">" + "Your order has been canceled ✖" + "</strong>" +
                        "<br>" +
                        "Order ID: <strong>" + ord.OrderID + "</strong>" +
                        "<br>" +
                        "Order Dispatched : <strong style=\"color: red;\">✖</strong>" +
                        "<br>" +
                        "Order Finished : <strong style=\"color: red;\">✖</strong>" +
                        "<br>" +
                        "Order Canceled : <strong style=\"color: red;\">✖</strong>" +
                        "<br>" +
                        "Your Name : <strong>" + customer.First_Name + "</strong>" +
                        "<br>" +
                        "Your Surname : <strong>" + customer.Last_Name + "</strong>" +
                        "<br>" +
                        "Your Email : <strong>" + customer.Email + "</strong>" +
                        "<br>" +
                        "Your Number : <strong>" + customer.Mobile1 + "</strong>" +
                        "<br>" +
                        "Your Country : <strong>" + customer.Country + "</strong>" +
                        "<br>" +
                        "Order Date : <strong>" + ord.OrderDate + "</strong>" +
                        "<br>";
            mail.Body += $"<br><br>If you are not satisfied with your order, you can let us know about the support.<br><br>Best regards,<br><strong>GameHub Support</strong>";

            using (SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587))
            {
                smtpClient.EnableSsl = true;
                smtpClient.Credentials = new NetworkCredential(senderEmail, senderPassword);


                try
                {
                    smtpClient.Send(mail);
                }
                catch (Exception)
                {
                    TempData["AlertMessageError"] = "Something went wrong, please try again.";
                }
            }

            TempData["AlertMessageSuccess"] = $"Order ID:{ord.OrderID} Canceled Successfully";
            return RedirectToAction("Details", new { id = ord.OrderID });
        }
    }
}