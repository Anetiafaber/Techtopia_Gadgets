using System;
using System.Web.UI;

namespace TechTopia_GroupProject
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Response.Redirect("~/ThankYou.aspx");
            }
        }

        protected void btnGoToCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Cart.aspx");
        }
    }
}
