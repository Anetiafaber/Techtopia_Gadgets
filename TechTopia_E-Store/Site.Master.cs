using System;
using System.Web;
using System.Web.UI;

namespace TechTopia_GroupProject
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the current page is Admin.aspx
            if (Request.Path.EndsWith("Admin", StringComparison.OrdinalIgnoreCase))
            {
                // Hide the cart and account buttons
                btnCart.Visible = false;
                btnProduct.Visible = false;               
                /*btnAccount.Visible = false;*/
            }
        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Session["Role"] = null;
            Session["Cart"] = null;

            // Clear the entire session
            Session.Clear();
            Session.Abandon();


            Response.Redirect("~/Login.aspx");
        }
    }
}
