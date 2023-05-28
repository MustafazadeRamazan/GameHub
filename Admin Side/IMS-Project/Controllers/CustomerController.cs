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
                string[] usernames = { customer.UserName }; // Assign the original username to the array

                if (customer.UserName.Contains(' '))
                {
                    usernames = customer.UserName.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries); // Split the username if it contains a space
                }

                bool isEmailExists = IsEmailExists(customer.Email);

                foreach (string username in usernames)
                {
                    if (IsUsernameExists(username))
                    {
                        TempData["AlertMessageError"] = "Username already exists. Please choose a different username.";
                        return RedirectToAction("Index", "Customer");
                    }
                }

                if (isEmailExists)
                {
                    TempData["AlertMessageError"] = "Email already exists. Please choose a different email.";
                    return RedirectToAction("Index", "Customer");
                }


                foreach (string username in usernames)
                {
                    Customer customers = new Customer
                    {
                        First_Name = customer.First_Name,
                        Last_Name = customer.Last_Name,
                        UserName = username,
                        Age = customer.Age,
                        Email = customer.Email,
                        Password = customer.Password,
                        Mobile1 = customer.Mobile1,
                        Country = customer.Country
                    };

                    db.Customers.Add(customers);
                    db.SaveChanges();
                    TempData["AlertMessageSuccess"] = $"Customer: {customers.First_Name} Created Successfully";
                    break;
                }

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

        private bool IsUsernameExists(string username)
        {
            var customers = db.Customers.ToList();
            foreach (var customer in customers)
            {
                if (customer.UserName == username)
                {
                    return true;
                }
            }
            return false;
        }

        private bool IsEmailExists(string email)
        {
            var customers = db.Customers.ToList();
            foreach (var customer in customers)
            {
                if (customer.Email == email)
                {
                    return true;
                }
            }
            return false;
        }

        //Post Edit
        [HttpPost]
        public ActionResult Edit(Customer cust)
        {
            if (ModelState.IsValid)
            {
                Customer existingCustomer = db.Customers.Find(cust.CustomerID);

                // Check if the provided email already exists in the database, excluding the case where the email belongs to the current customer being updated.
                if (existingCustomer.Email != cust.Email && IsEmailExists(cust.Email))
                {
                    TempData["AlertMessageError"] = $"Customer ID: {cust.CustomerID} Email already exists. Please choose a different email.";
                    return RedirectToAction("Index", "Customer");
                }

                // Split the new username by space if necessary
                string[] newUsername = cust.UserName.Split(' ');

                // If the username is changed, check if the new username(s) already exist.
                if (!string.Equals(existingCustomer.UserName, cust.UserName, StringComparison.OrdinalIgnoreCase) && IsAnyUsernameExists(newUsername))
                {
                    TempData["AlertMessageError"] = $"Customer ID: {cust.CustomerID} Username already exists. Please choose a different username.";
                    return RedirectToAction("Index", "Customer");
                }

                existingCustomer.First_Name = cust.First_Name;
                existingCustomer.Last_Name = cust.Last_Name;
                existingCustomer.UserName = cust.UserName;
                existingCustomer.Age = cust.Age;
                existingCustomer.Picture = cust.Picture;
                existingCustomer.State = cust.State;
                existingCustomer.City = cust.City;
                existingCustomer.PostalCode = cust.PostalCode;
                existingCustomer.Address1 = cust.Address1;
                existingCustomer.Email = cust.Email;
                existingCustomer.Password = cust.Password;
                existingCustomer.Mobile1 = cust.Mobile1;
                existingCustomer.Country = cust.Country;

                db.Entry(existingCustomer).State = EntityState.Modified;
                db.SaveChanges();

                TempData["AlertMessageSuccess"] = $"Customer ID: {cust.CustomerID} Updated Successfully";
                return RedirectToAction("Index", "Customer");
            }

            return View(cust);
        }

        private bool IsAnyUsernameExists(string[] usernames)
        {
            foreach (string username in usernames)
            {
                if (IsUsernameExists(username))
                {
                    return true;
                }
            }

            return false;
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