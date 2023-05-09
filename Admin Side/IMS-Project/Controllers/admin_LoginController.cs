using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IMS_Project.Models;

namespace IMS_Project.Controllers
{
    public class admin_LoginController : Controller
    {
        GameHubEntities db = new GameHubEntities();
        // GET: admin_Login
        public ActionResult Index()
        {
            return View();
        }        

        [HttpPost]
        public ActionResult Login(admin_Login login)
        {
            if (ModelState.IsValid)
            {
                var model = (from m in db.admin_Employee
                             where m.FirstName == login.UserName && m.LastName == login.Password
                            select m).Any();
                if (model)
                {                 
                    var loginInfo = db.admin_Employee.Where(x=>x.FirstName==login.UserName && x.LastName==login.Password).FirstOrDefault();

                    Session["username"] = loginInfo.FirstName;
                    TemData.EmpID = loginInfo.EmpID;
                    TempData["AlertMessageSuccess"] = $"Welcome Back! {login.UserName}";
                    return RedirectToAction("Index", "Dashboard");
                }       
            }
            TempData["AlertMessageError"] = "The username or password is incorrect, please try again.";
            return View("Index");
        }
        public ActionResult Logout()
        {
            Session.Clear();
            TempData["AlertMessageSuccess"] = "Successfully Logged Out!";
            return RedirectToAction("Index", "admin_Login");
        }
    }
}