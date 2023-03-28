using GameHub.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace GameHub.Controllers
{
    public class HomeController : Controller
    {
        GameHubEntities db = new GameHubEntities();

        // GET: Home
        public ActionResult Index()
        {
            ViewBag.MenProduct = db.Products.Where(x => x.Category.Name.Equals("Game Accounts")).ToList();
            ViewBag.WomenProduct = db.Products.Where(x => x.Category.Name.Equals("Game Projects")).ToList();
            ViewBag.SportsProduct = db.Products.Where(x => x.Category.Name.Equals("Laptops")).ToList();
            ViewBag.ElectronicsProduct = db.Products.Where(x => x.Category.Name.Equals("Gaming Accessories")).ToList();
            ViewBag.Slider = db.genMainSliders.ToList();
            ViewBag.PromoRight = db.genPromoRights.ToList();

            this.GetDefaultData();

            return View();
        }      

    }
}