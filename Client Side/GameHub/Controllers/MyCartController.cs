using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameHub.Models;


namespace GameHub.Controllers
{
    public class MyCartController : Controller
    {
        GameHubEntities db = new GameHubEntities();

        // GET: MyCart
        public ActionResult Index()
        {
             var data=this.GetDefaultData();

            return View(data);
            
        }

        public ActionResult Remove(int id)
        {
            var product = db.Products.Find(id);
            TempShpData.items.RemoveAll(x=>x.ProductID==id);
            TempData["AlertMessageSuccess"] = $"{product.Name} removed from the cart";
            return RedirectToAction("Index");

        }

        [HttpPost]
        public ActionResult UpdateItemQuantity(int id, int quantity)
        {
            var itemToUpdate = TempShpData.items.FirstOrDefault(x => x.ProductID == id);
            if (itemToUpdate != null)
            {
                itemToUpdate.Quantity = quantity;
                itemToUpdate.TotalAmount = itemToUpdate.UnitPrice * quantity;
            }
            return Json(new { success = true });
        }
        [HttpPost]
        public ActionResult IncreaseQuantity(int id)
        {
            var product = db.Products.Find(id);
            var itemToUpdate = TempShpData.items.FirstOrDefault(x => x.ProductID == id);
            if (itemToUpdate != null)
            {
                if (product.UnitInStock > itemToUpdate.Quantity)
                {
                    itemToUpdate.Quantity++;
                    itemToUpdate.TotalAmount = itemToUpdate.UnitPrice * itemToUpdate.Quantity;
                    TempData["AlertMessageSuccess"] = $"Quantity of {product.Name} increased in the cart";
                }
                else
                {
                    TempData["AlertMessageError"] = $"Quantity of {product.Name} is out of stock";
                    return Json(new { success = false });
                }
            }
            return Json(new { success = true });
        }

        [HttpPost]
        public ActionResult DecreaseQuantity(int id)
        {
            var product = db.Products.Find(id);
            var itemToUpdate = TempShpData.items.FirstOrDefault(x => x.ProductID == id);
            if (itemToUpdate != null)
            {
                if (itemToUpdate.Quantity > 1)
                {
                    itemToUpdate.Quantity--;
                    itemToUpdate.TotalAmount = itemToUpdate.UnitPrice * itemToUpdate.Quantity;
                    TempData["AlertMessageSuccess"] = $"Cart Page Updated Successfully";
                }
                else
                {
                    TempShpData.items.RemoveAll(x => x.ProductID == id);
                    TempData["AlertMessageSuccess"] = $"{product.Name} removed from the cart";
                    return Json(new { success = true, removeItem = true });
                }
            }
            return Json(new { success = true });
        }


        [HttpPost]
        public ActionResult ProcedToCheckout(FormCollection formcoll)
        {
            TempShpData.items.ToList();

            return RedirectToAction("Index", "CheckOut");
        }
        
        
    }
}