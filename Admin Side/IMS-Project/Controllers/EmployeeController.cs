﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IMS_Project.Models;
using System.Data;

namespace IMS_Project.Controllers
{
    public class EmployeeController : Controller
    {
        GameHubEntities db = new GameHubEntities();

        public ActionResult Index()
        {
            return View(db.admin_Employee.ToList());
        }
        
        public ActionResult Create()
        {            
            return View();
        }

        [HttpPost]
        public ActionResult Create(admin_Employee emp)
        {
            if (ModelState.IsValid)
            {
                db.admin_Employee.Add(emp);
                db.SaveChanges();
                TempData["AlertMessageSuccess"] = $"{emp.Email}: {emp.FirstName} Created Successfully";
                return RedirectToAction("Index");
            }
           
            return View();
        }

        [HttpGet]
        public ActionResult Edit(int id)
        {
            admin_Employee emp = db.admin_Employee.Single(x => x.EmpID == id);
            if (emp==null)
            {
                return HttpNotFound();
            }
            //ViewBag.RoleID = new SelectList(db.Roles, "RoleID", "RoleName", emp.RoleID);
            return View("Edit",emp);
        }

        [HttpPost]
        public ActionResult Edit(admin_Employee emp)
        {
            if (ModelState.IsValid)
            {
                db.Entry(emp).State = EntityState.Modified;
                db.SaveChanges();
                TempData["AlertMessageSuccess"] = $"{emp.Email} ID: {emp.EmpID} Updated Successfully";
                return RedirectToAction("Index");
            }
            //ViewBag.RoleID = new SelectList(db.Roles, "RoleID", "RoleName", emp.RoleID);
            return View(emp);
        }


        public ActionResult Details(int id)
        {
           admin_Employee emp= db.admin_Employee.Find(id);
           if (emp==null)
           {
               return HttpNotFound();
           }
           return View(emp);
        }


        public ActionResult Delete(int id)
        {
            admin_Employee emp = db.admin_Employee.Find(id);
            if (emp==null)
            {
                return HttpNotFound();
            }
            return View(emp);
 
        }


        [HttpPost,ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            admin_Employee admin_Employee = db.admin_Employee.Find(id);
            try
            {
                db.admin_Employee.Remove(admin_Employee);
                db.SaveChanges();
                TempData["AlertMessageSuccess"] = $"{admin_Employee.Email}: {admin_Employee.FirstName}, ID: {admin_Employee.EmpID}  Deleted Successfully";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                TempData["AlertMessageError"] = $"You cannot delete the primary Admin: {admin_Employee.FirstName}, ID: {admin_Employee.EmpID}";
                return RedirectToAction("Index");
            }
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }
        
    }
}