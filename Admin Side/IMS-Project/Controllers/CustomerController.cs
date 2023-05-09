using IMS_Project.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace IMS_Project.Controllers
{
    public class CustomerController : Controller
    {
        GameHubEntities db = new GameHubEntities();

        public ActionResult Index()
        {
            return View(db.Customers.ToList());
        }

        public ActionResult Create()
        {          
            return View();
        }

        [HttpPost]
        public ActionResult Create(Customer customer)
        {
            if (ModelState.IsValid)
            {
                db.Customers.Add(customer);
                db.SaveChanges();
                TempData["AlertMessageSuccess"] = $"Customer: {customer.First_Name} Created Successfully";
                return RedirectToAction("Index", "Customer");
            }
            return View();
        }

        //Get Edit
        [HttpGet]
        public ActionResult Edit(int id)
        {
            Customer cust = db.Customers.Single(x => x.CustomerID == id);
            if (cust == null)
            {
                return HttpNotFound();
            }
           
            return View("Edit", cust);
        }

        //Post Edit
        [HttpPost]
        public ActionResult Edit(Customer cust)
        {
            if (ModelState.IsValid)
            {
                db.Entry(cust).State = EntityState.Modified;
                db.SaveChanges();
                TempData["AlertMessageSuccess"] = $"Customer ID: {cust.CustomerID} Updated Successfully";
                return RedirectToAction("Index", "Customer");
            }

            return View(cust);
        }

        //Get Details
        public ActionResult Details(int id)
        {
            Customer cust = db.Customers.Find(id);
            if (cust == null)
            {
                return HttpNotFound();
            }
            return View(cust);
        }

        //Get Delete
        public ActionResult Delete(int id)
        {
            Customer cust = db.Customers.Find(id);
            if (cust == null)
            {
                return HttpNotFound();
            }
            return View(cust);

        }

        //Post Delete Confirmed
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Customer cust = db.Customers.Find(id);
            try
            {
                db.Customers.Remove(cust);
                db.SaveChanges();
                TempData["AlertMessageSuccess"] = $"Customer {cust.First_Name}, ID: {cust.CustomerID}  Deleted Successfully";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["AlertMessageError"] = $"An error occurred while deleting the Customer: {cust.First_Name}, ID: {cust.CustomerID}";
                return RedirectToAction("Index");
            }
        }


        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }
    }
}