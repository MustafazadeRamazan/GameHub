using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameHub.Models;


namespace GameHub.Controllers
{
    public class OrderController : Controller
    {
        GameHubEntities db = new GameHubEntities();
        public ActionResult Index()
        {
            var userId = TempShpData.UserID;
            var orders = db.Orders.Where(x => x.CustomerID == userId).OrderByDescending(x => x.OrderID).ToList();
            return View(orders);
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

            if (ord.CancelOrder == true)
            {
                ViewBag.ShowFinishButton = false;
            }

            if (ord.CancelOrder == false)
            {

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

        public ActionResult Finish(int id)
        {
            Order ord = db.Orders.Find(id);
            ord.DeliveryDate = DateTime.Now;
            ord.Deliver = true;
            db.SaveChanges();

            TempData["AlertMessageSuccess"] = $"Thank You for Shopping With Us!";
            return RedirectToAction("Details", new { id = ord.OrderID });
        }


    }
}