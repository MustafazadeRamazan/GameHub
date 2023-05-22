using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameHub.Models;

namespace GameHub.Controllers
{
    public class WishListController : Controller
    {
        GameHubEntities db = new GameHubEntities();

        // GET: WishList
        public ActionResult Index()
        {
             this.GetDefaultData();

            var wishlistProducts = db.Wishlists.Where(x => x.CustomerID == TempShpData.UserID).ToList();
            return View(wishlistProducts);
        }

        //REMOVE ITEM FROM WISHLIST
        public ActionResult Remove(int id)
        {
            int productId = db.Wishlists.Find(id).ProductID;
            var product = db.Products.Find(productId);
            db.Wishlists.Remove(db.Wishlists.Find(id));
            db.SaveChanges();
            TempData["AlertMessageSuccess"] = $"{product.Name} removed from the wishlists";
            return RedirectToAction("Index");

        }
        //ADD TO CART WISHLIST
        public ActionResult AddToCart(int id)
        {
            int productId = db.Wishlists.Find(id).ProductID;
            var product = db.Products.Find(productId);

            if (TempShpData.items == null)
            {
                TempShpData.items = new List<OrderDetail>();
            }

            OrderDetail existingItem = TempShpData.items.FirstOrDefault(item => item.ProductID == productId);
            if (existingItem != null)
            {
                if (product.UnitInStock > existingItem.Quantity)
                {
                    existingItem.Quantity++;
                    existingItem.TotalAmount = existingItem.Quantity * existingItem.UnitPrice;
                    TempData["AlertMessageSuccess"] = $"Quantity of {product.Name} increased in the cart";
                }
                else
                {
                    TempData["AlertMessageError"] = $"Quantity of {product.Name} is out of stock";
                    return RedirectToAction("Index");
                }
            }
            else
            {
                OrderDetail newOrderDetail = new OrderDetail();
                newOrderDetail.ProductID = productId;
                newOrderDetail.Quantity = 1;
                newOrderDetail.UnitPrice = db.Products.Find(productId).UnitPrice;
                newOrderDetail.TotalAmount = newOrderDetail.Quantity * newOrderDetail.UnitPrice;
                newOrderDetail.Product = db.Products.Find(productId);
                TempShpData.items.Add(newOrderDetail);
                TempData["AlertMessageSuccess"] = $"{product.Name} added to the cart";
            }

            db.Wishlists.Remove(db.Wishlists.Find(id));
            db.SaveChanges();

            return RedirectToAction("Index");
        }

    }
}