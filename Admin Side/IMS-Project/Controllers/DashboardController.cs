using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IMS_Project.Models;
using System.Data.Objects;

namespace IMS_Project.Controllers
{
    public class DashboardController : Controller
    {
        GameHubEntities db = new GameHubEntities();
        public ActionResult Index() 
        {          

            ViewBag.latestOrders = db.Orders.OrderByDescending(x => x.OrderID).Take(10).ToList();
            ViewBag.NewOrders = db.Orders.Count(a => a.DIspatched == false && a.Deliver == false && a.CancelOrder == false);
            ViewBag.DispatchedOrders = db.Orders.Count(a => a.DIspatched == true && a.Deliver == false && a.CancelOrder == false);
            ViewBag.ShippedOrders = db.Orders.Where(a => a.CancelOrder == true).Count();
            ViewBag.DeliveredOrders = db.Orders.Count(a => a.DIspatched == true && a.Deliver == true && a.CancelOrder == false);

            return View();
        }
        
        public JsonResult GetSalesPerDay()
        {
            var data = (from O in db.Orders
                        select new { date = EntityFunctions.TruncateTime(O.OrderDate), O.TotalAmount } into a
                        group a by a.date into b
                        select new
                        {
                            period = b.Key,
                            sales = b.Sum(x => x.TotalAmount)
                        });
           
            List<AreaCharts> aa=new List<AreaCharts>();
            foreach (var item in data)
            {
                string date = item.period.ToString().Split(new[] { (' ') }, StringSplitOptions.None)[0];            
                aa.Add(new AreaCharts(){period=date,sales=item.sales.GetValueOrDefault()});
            }         
            return Json(aa, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetTopProductSales()
        {
            var dataforchart = (from OD in db.OrderDetails
                                join P in db.Products
                                on OD.ProductID equals P.ProductID
                                select new { P.Name, OD.Quantity } into row
                                group row by row.Name into g
                                select new
                                {
                                    label = g.Key,
                                    value = g.Sum(x => x.Quantity)
                                })
                    .OrderByDescending(x => x.value)
                    .Take(3);
            return Json(dataforchart, JsonRequestBehavior.AllowGet);
        }
        

        public JsonResult GetOrderPerDay()
        {
            var data = from O in db.Orders
                       select new { Odate = EntityFunctions.TruncateTime(O.OrderDate), O.OrderID } into g
                       group g by g.Odate into col
                       select new
                       {
                           Order_Date = col.Key,
                           Count = col.Count(y=>y.OrderID!=null)
                       };
            List<LineCharts> aa = new List<LineCharts>();
            foreach (var item in data)
            {
                string date = item.Order_Date.ToString().Split(new[] { (' ') }, StringSplitOptions.None)[0];
                aa.Add(new LineCharts() { Date = date, Orders = item.Count });
            } 
            return Json(aa, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSalesPerCountry()
        {
            var dataforBarchart = (from O in db.Orders
                                join C in db.Customers
                                on O.CustomerID equals C.CustomerID
                                select new { C.Country,O.TotalAmount } into row
                                group row by row.Country into g
                                select new
                                {
                                    Country = g.Key,
                                    Sales_Amount = g.Sum(x => x.TotalAmount)
                                })
                              .OrderByDescending(x => x.Sales_Amount)
                              .Take(6);
            return Json(dataforBarchart, JsonRequestBehavior.AllowGet);
        }

    }
}