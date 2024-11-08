﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GameHub.Models;
using PagedList;
using PagedList.Mvc;

namespace GameHub.Controllers
{
    public class ProductController : Controller
    {
        GameHubEntities db = new GameHubEntities();


        public ActionResult Index()
        {
            ViewBag.Categories = db.Categories.Select(x => x.Name).ToList();

            ViewBag.TopRatedProducts = TopSoldProducts();
            ViewBag.RecentViewsProducts = RecentViewProducts();

            return View("Products");
        }

        public List<TopSoldProduct> TopSoldProducts()
        {
            var prodList = (from prod in db.OrderDetails
                            select new { prod.ProductID, prod.Quantity } into p
                            group p by p.ProductID into g
                            select new
                            {
                                pID = g.Key,
                                sold = g.Sum(x => x.Quantity)
                            }).OrderByDescending(y => y.sold).Take(3).ToList();



            List<TopSoldProduct> topSoldProds = new List<TopSoldProduct>();

            for (int i = 0; i < 3; i++)
            {
                topSoldProds.Add(new TopSoldProduct()
                {
                    product = db.Products.Find(prodList[i].pID),
                    CountSold = Convert.ToInt32(prodList[i].sold)
                });
            }
            return topSoldProds;
        }

        public IEnumerable<Product> RecentViewProducts()
        {
            if (TempShpData.UserID > 0)
            {
                var top3Products = (from recent in db.RecentlyViews
                                    where recent.CustomerID == TempShpData.UserID
                                    orderby recent.ViewDate descending
                                    select recent.ProductID).ToList().Take(3);

                var recentViewProd = db.Products.Where(x => top3Products.Contains(x.ProductID));
                return recentViewProd;
            }
            else
            {
                var prod = (from p in db.Products
                            select p).OrderByDescending(x => x.UnitPrice).Take(3).ToList();
                return prod;
            }
        }


        public ActionResult AddToCart(int id)
        {
            string name = db.Products.Find(id).Name;
            var product = db.Products.Find(id);

            if (TempShpData.items == null)
            {
                TempShpData.items = new List<OrderDetail>();
            }


            OrderDetail existingItem = TempShpData.items.FirstOrDefault(item => item.ProductID == id);
            if (existingItem != null)
            {
                if (product.UnitInStock > existingItem.Quantity)
                {
                    existingItem.Quantity++;
                    existingItem.TotalAmount = existingItem.Quantity * existingItem.UnitPrice;
                    TempData["AlertMessageSuccess"] = $"Quantity of {name} increased in the cart";
                }
                else
                {
                    TempData["AlertMessageError"] = $"Quantity of {name} is out of stock";
                }
            }
            else
            {
                OrderDetail newOrderDetail = new OrderDetail();
                newOrderDetail.ProductID = id;
                newOrderDetail.Quantity = 1;
                newOrderDetail.UnitPrice = db.Products.Find(id).UnitPrice;
                newOrderDetail.TotalAmount = newOrderDetail.Quantity * newOrderDetail.UnitPrice;
                newOrderDetail.Product = db.Products.Find(id);
                TempShpData.items.Add(newOrderDetail);
                TempData["AlertMessageSuccess"] = $"{name} added to the cart";
            }

            AddRecentViewProduct(id);

            return Redirect(TempData["returnURL"].ToString());
        }


        public ActionResult ViewDetails(int id)
        {
            var prod = db.Products.Find(id);
            var reviews = db.Reviews.Where(x => x.ProductID == id).ToList();
            ViewBag.Reviews = reviews;
            var usr = db.Customers.Find(TempShpData.UserID);
            if(usr != null)
            {
                ViewBag.CustomerName = usr.First_Name;
                ViewBag.CustomerSurName = usr.Last_Name;
            }
            ViewBag.TotalReviews = reviews.Count();
            ViewBag.RelatedProducts = db.Products.Where(y => y.CategoryID == prod.CategoryID).ToList();
            AddRecentViewProduct(id);

            var ratedProd=db.Reviews.Where(x => x.ProductID == id).ToList();
            int count = ratedProd.Count();
            int TotalRate =  ratedProd.Sum(x => x.Rate).GetValueOrDefault();
            ViewBag.AvgRate = TotalRate > 0 ? TotalRate / count : 0;

            this.GetDefaultData();
            return View(prod);
        }

        public ActionResult WishList(int id)
        {
            
            Wishlist wl = new Wishlist();
            string name = db.Products.Find(id).Name;
            wl.ProductID = id;
            wl.CustomerID = TempShpData.UserID;

            db.Wishlists.Add(wl);
            db.SaveChanges();
            AddRecentViewProduct(id);
            ViewBag.WlItemsNo = db.Wishlists.Where(x => x.CustomerID == TempShpData.UserID).ToList().Count();
            if (TempData["returnURL"].ToString()=="/")
            {
                TempData["AlertMessageSuccess"] = $"{name} added to WishList";
                return RedirectToAction("Index","Home");
            }
            TempData["AlertMessageSuccess"] = $"{name} added to WishList";
            return Redirect(TempData["returnURL"].ToString());
        }

        public void AddRecentViewProduct(int pid)
        {
            if (TempShpData.UserID > 0)
            {
                RecentlyView Rv = new RecentlyView();
                Rv.CustomerID = TempShpData.UserID;
                Rv.ProductID = pid;
                Rv.ViewDate = DateTime.Now;
                db.RecentlyViews.Add(Rv);
                db.SaveChanges();
            }
        }


        public ActionResult AddReview(int productID, FormCollection getReview)
        {

            Review r = new Review();
            string name = db.Products.Find(productID).Name;
            r.CustomerID = TempShpData.UserID;
            r.ProductID = productID;
            r.Name = getReview["name"];
            r.Email = getReview["email"];
            r.Review1 = getReview["message"];
            r.Rate = Convert.ToInt32(getReview["rate"]);
            r.DateTime = DateTime.Now;

            db.Reviews.Add(r);
            db.SaveChanges();
            TempData["AlertMessageSuccess"] = $"Review added to {name}";
            return RedirectToAction("ViewDetails/" + productID + "");

        }


        public ActionResult Products(int subCatID)
        {
            ViewBag.Categories = db.Categories.Select(x => x.Name).ToList();
            var prods = db.Products.Where(y => y.SubCategoryID == subCatID).ToList();
            return View(prods);
        }


        public ActionResult GetProductsByCategory(string categoryName, int? page)
        {
            ViewBag.Categories = db.Categories.Select(x => x.Name).ToList();
            ViewBag.TopRatedProducts = TopSoldProducts();
         
            ViewBag.RecentViewsProducts = RecentViewProducts();

            var prods = db.Products.Where(x => x.Category.Name == categoryName).ToList();
            return View("Products", prods.ToPagedList(page ?? 1, 9));
        }


        public ActionResult Search(string product,int? page)
        {
            ViewBag.Categories = db.Categories.Select(x => x.Name).ToList();
            ViewBag.TopRatedProducts = TopSoldProducts();
          
            ViewBag.RecentViewsProducts = RecentViewProducts();

            List<Product> products;
            if (!string.IsNullOrEmpty(product))
            {
                products = db.Products.Where(x => x.Name.StartsWith(product)).ToList();
            }
            else
            {
                products = db.Products.ToList();
            }
            return View("Products", products.ToPagedList(page ?? 1,6));
        }

        public JsonResult GetProducts(string term)
        {
            List<string> prodNames = db.Products.Where(x => x.Name.StartsWith(term)).Select(y => y.Name).ToList();
            return Json(prodNames, JsonRequestBehavior.AllowGet);

        }
        public ActionResult FilterByPrice(int minPrice,int maxPrice,int? page)
        {
            ViewBag.Categories = db.Categories.Select(x => x.Name).ToList();
            ViewBag.TopRatedProducts = TopSoldProducts();

            ViewBag.RecentViewsProducts = RecentViewProducts();
            ViewBag.filterByPrice = true;
           var filterProducts= db.Products.Where(x => x.UnitPrice >= minPrice && x.UnitPrice <= maxPrice).ToList();
           return View("Products", filterProducts.ToPagedList(page ?? 1, 9));
        }

       
    }
}