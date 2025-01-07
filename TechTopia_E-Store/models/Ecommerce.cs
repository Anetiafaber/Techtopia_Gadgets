using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TechTopia_GroupProject.models
{
    public class Ecommerce
    {

        public string ProductID { get; set; }
        public string ProductName { get; set; }
        public decimal Price { get; set; }
        public string CategoryID { get; set; }
        public string StockQuantity { get; set; }
        public string Image { get; set; }
        public string ShortDescription { get; set; }
        public string LongDescription { get; set; }
        
    }
}