using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GameHub.Models
{
    public class TopSoldProduct
    {
        public Product product { get; set; }
        public int CountSold { get; set; }
    }
}