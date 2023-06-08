using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameHub.Models;

namespace GameHub.Controllers
{
    public class ThankYouController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.cartBox = null;
            ViewBag.Total = null;
            ViewBag.NoOfItem = null;
            TempShpData.items = null;
            return View("Thankyou");
        }
    }
}