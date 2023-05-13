using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IMS_Project.Models;

namespace IMS_Project.Controllers
{
    public class OrderController : Controller
    {
        GameHubEntities db = new GameHubEntities();
        // GET: Order
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

            if (ord.DIspatched == false)
            {
                ViewBag.ShowDispatchButton = true;
            }
            else
            {
                ViewBag.ShowDispatchButton = false;
            }

            if (ord.DIspatched == true && ord.Deliver == false)
            {
                ViewBag.ShowFinishButton = true;
            }
            else
            {
                ViewBag.ShowFinishButton = false;
            }

            return View(tuple);
        }

        public ActionResult Dispatch(int id)
        {
            Order ord = db.Orders.Find(id);
            ord.DispatchedDate = DateTime.Now;
            ord.DIspatched = true;
            db.SaveChanges();

            TempData["AlertMessageSuccess"] = $"Order {ord.OrderID} Dispatched Successfully";
            return RedirectToAction("Details", new { id = ord.OrderID });
        }

        public ActionResult Finish(int id)
        {
            Order ord = db.Orders.Find(id);
            ord.DeliveryDate = DateTime.Now;
            ord.Deliver = true;
            db.SaveChanges();

            TempData["AlertMessageSuccess"] = $"Order {ord.OrderID} Finished Successfully";
            return RedirectToAction("Details", new { id = ord.OrderID });
        }
    }
}