﻿using IMS_Project.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace IMS_Project.Controllers
{
    public class ProductController : Controller
    {
        GameHubEntities db = new GameHubEntities();

        public ActionResult Index()
        {
            return View(db.Products.ToList());
        }

        public ActionResult Create()
        {
            GetViewBagData();
            return View();
        }
        public void GetViewBagData()
        {
            ViewBag.SupplierID = new SelectList(db.Suppliers, "SupplierID", "CompanyName");
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "Name");
            //ViewBag.SubCategoryID = new SelectList(db.SubCategories, "SubCategoryID", "Name");

        }

        [HttpPost]
        public ActionResult Create(Product prod)
        {
            if (ModelState.IsValid)
            {
                //foreach (var file in Picture1)
                //{
                //    if (file != null || file.ContentLength > 0)
                //    {
                //        string ext = System.IO.Path.GetExtension(file.FileName);
                //        if (ext == ".png" || ext == ".jpg" || ext == ".jpeg")
                //        {
                //            file.SaveAs(Path.Combine(Server.MapPath("/Content/Images/large"), Guid.NewGuid() + Path.GetExtension(file.FileName)));

                //            var medImg= Images.ResizeImage(Image.FromFile(file.FileName), 250, 300);
                //            medImg.Save(Path.Combine(Server.MapPath("/Content/Images/medium"), Guid.NewGuid() + Path.GetExtension(file.FileName)));
                            

                //            var smImg = Images.ResizeImage(Image.FromFile(file.FileName), 45, 55);
                //            smImg.Save(Path.Combine(Server.MapPath("/Content/Images/small"), Guid.NewGuid() + Path.GetExtension(file.FileName)));
                        
                //        }
                //    }
                //    db.Products.Add(prod);
                //    db.SaveChanges();
                //    return RedirectToAction("Index", "Product");
                //}
                db.Products.Add(prod);
                db.SaveChanges();
                TempData["AlertMessageSuccess"] = $"Product: {prod.Name} Created Successfully";
                return RedirectToAction("Index", "Product");
            }
            GetViewBagData();
            return View();
        }


        [HttpGet]
        public ActionResult Edit(int id)
        {
            Product product = db.Products.Single(x => x.ProductID == id);
            if (product == null)
            {
                return HttpNotFound();
            }
            GetViewBagData();
            return View("Edit", product);
        }


        [HttpPost]
        public ActionResult Edit(Product prod)
        {
            if (ModelState.IsValid)
            {
                db.Entry(prod).State = EntityState.Modified;
                db.SaveChanges();
                TempData["AlertMessageSuccess"] = $"Product ID: {prod.ProductID} Updated Successfully";
                return RedirectToAction("Index", "Product");
            }
            GetViewBagData();
            return View(prod);
        }

        public ActionResult Details(int id)
        {
            Product  product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }


        public ActionResult Delete(int id)
        {
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);

        }


        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            try
            {
                db.Products.Remove(product);
                db.SaveChanges();
                TempData["AlertMessageSuccess"] = $"Product: {product.Name}, ID: {product.ProductID}  Deleted Successfully";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["AlertMessageError"] = $"An error occurred while deleting the Product: {product.Name}, ID: {product.ProductID}";
                return RedirectToAction("Index");
            }
        }


        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }
        
    }
}