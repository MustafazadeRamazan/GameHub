using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameHub.Models;
using System.Data;
using System.Net.Mail;
using System.Net;

namespace GameHub.Controllers
{
    public class CheckOutController : Controller
    {
        GameHubEntities db = new GameHubEntities();
        string senderEmail = "your-email@gmail.com"; // Update with your email address
        string senderPassword = "your-password"; // Update with your email password

        public ActionResult Index()
        {
            ViewBag.PayMethod = new SelectList(db.PaymentTypes, "PayTypeID", "TypeName");
            
               
            var data=this.GetDefaultData();
         
            return View(data);
        }

        
        public ActionResult PlaceOrder(FormCollection getCheckoutDetails)
        {            

                int shpID = 1;
                if (db.ShippingDetails.Count() > 0)
                {
                    shpID = db.ShippingDetails.Max(x => x.ShippingID) + 1;
                }
                int payID = 1;
                if (db.Payments.Count() > 0)
                {
                    payID = db.Payments.Max(x => x.PaymentID) + 1;
                }
                int orderID = 1;
                if (db.Orders.Count() > 0)
                {
                    orderID = db.Orders.Max(x => x.OrderID) + 1;
                }



                ShippingDetail shpDetails = new ShippingDetail();
                shpDetails.ShippingID = shpID;
                shpDetails.FirstName = "user";
                shpDetails.LastName = "user";
                shpDetails.Email = getCheckoutDetails["Email"];
                shpDetails.Mobile = "user";
                shpDetails.Address = getCheckoutDetails["Address"];
                shpDetails.Province = "user";
                shpDetails.City = "user";
                shpDetails.PostCode = "user";
                db.ShippingDetails.Add(shpDetails);

                Payment pay = new Payment();
                pay.PaymentID = payID;
                pay.Type = Convert.ToInt32(getCheckoutDetails["PayMethod"]);
                db.Payments.Add(pay);

                Order o = new Order();
                o.OrderID = orderID;
                o.CustomerID = TempShpData.UserID;
                o.PaymentID = payID;
                o.ShippingID = shpID;
                o.Discount = Convert.ToInt32( getCheckoutDetails["discount"]);
                o.TotalAmount = Convert.ToInt32( getCheckoutDetails["totalAmount"]);
                o.isCompleted = true;
                o.OrderDate = DateTime.Now;
                o.DIspatched = false;
                o.Deliver = false;
                o.CancelOrder = false;
                db.Orders.Add(o);

            List<OrderDetail> orderDetails = new List<OrderDetail>();
            var userId = TempShpData.UserID;
                var customer = db.Customers.Find(userId);

                foreach (var OD in TempShpData.items)
                {
                    OD.OrderID = orderID;
                    OD.Order = db.Orders.Find(orderID);
                    OD.Product = db.Products.Find(OD.ProductID);
                    if(OD.Product.UnitInStock >= OD.Quantity)
                    {
                        OD.Product.UnitInStock -= OD.Quantity;
                        db.OrderDetails.Add(OD);
                        db.SaveChanges();
                        orderDetails.Add(OD);
                }
                    else
                    {
                        TempData["AlertMessageError"] = $"{OD.Product.Name} is out of stock";
                        return RedirectToAction("Index", "CheckOut");
                    }
                }
            SendPurchaseDetailsEmail(customer.Email, o, shpDetails, orderDetails);
            return RedirectToAction("Index","ThankYou");
            
        }

        private void SendPurchaseDetailsEmail(string email, Order order, ShippingDetail shipping, List<OrderDetail> orderDetails)
        {
            var userId = TempShpData.UserID;
            var customer = db.Customers.Find(userId);

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(senderEmail);
            mail.To.Add(email);
            mail.Subject = "Purchase Details";
            mail.IsBodyHtml = true;
            mail.Body = "Hi <strong>" + customer.UserName + "</strong>," +
                        "<br><br>" +
                        "Thank you for your purchase! Here are your order details:" +
                        "<br>" +
                        "Order ID: <strong>" + order.OrderID + "</strong>" +
                        "<br>" +
                        "Order Dispatched : <strong>✖</strong>" +
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
                        "Order Date : <strong>" + order.OrderDate + "</strong>" +
                        "<br>" +
                        "Order Dispatched : <strong>-</strong>" +
                        "<br>" +
                        "Order Finished : <strong>-</strong>" +
                        "<br>" +
                        "Shipping to Email : <strong>" + shipping.Email + "</strong>" +
                        "<br>" +
                        "Your Note : <strong>" + shipping.Address + "</strong>" +
                        "<br>" +
                        "Total Amount: <strong>" + order.TotalAmount + "$</strong>" +
                        "<br><br>" +
                        "[List of items]" +
                        "<br>";

            foreach (var orderDetail in orderDetails)
            {
                mail.Body += $"Product Name: <strong>{orderDetail.Product.Name}</strong>, Quantity: <strong>{orderDetail.Quantity}</strong>, Price: <strong>{orderDetail.UnitPrice}$</strong><br>";
            }
            mail.Body += $"<br><br>Please note that the provided invoice address is not a returns address. For any queries or concerns regarding your purchase, please contact our customer support.<br>Thank you once again for choosing GameHub.<br>Best regards,<br><strong>GameHub Support</strong>";

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
        }


    }
}