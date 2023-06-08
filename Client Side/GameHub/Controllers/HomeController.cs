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

        public ActionResult Index()
        {
            ViewBag.FpsGames = db.Products.Where(x => x.Category.Name.Equals("Fps Games")).ToList();
            ViewBag.GameProjects = db.Products.Where(x => x.Category.Name.Equals("Game Projects")).ToList();
            ViewBag.SportsProduct = db.Products.Where(x => x.Category.Name.Equals("Sport Games")).ToList();
            ViewBag.ActionAdventure = db.Products.Where(x => x.Category.Name.Equals("Action Adventure")).ToList();
            ViewBag.SurvivalGames = db.Products.Where(x => x.Category.Name.Equals("Survival Games")).ToList();
            ViewBag.Slider = db.genMainSliders.ToList();
            ViewBag.PromoRight = db.genPromoRights.ToList();

            this.GetDefaultData();

            return View();
        }      

    }
}