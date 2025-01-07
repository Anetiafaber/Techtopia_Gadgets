using System;
using System.Data;
using System.Web.UI.WebControls;

namespace TechTopia_GroupProject
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCart();
            }
        }

        private void BindCart()
        {
            if (Session["Cart"] != null)
            {
                DataTable cart = (DataTable)Session["Cart"];
                CartGridView.DataSource = cart;
                CartGridView.DataBind();

                // Calculate the total
                decimal total = 0;
                foreach (DataRow row in cart.Rows)
                {

                    decimal price;
                    int quantity;

                    bool isPriceValid = decimal.TryParse(row["Price"].ToString(), out price);
                    bool isQuantityValid = int.TryParse(row["Quantity"].ToString(), out quantity);

                    if (isPriceValid && isQuantityValid)
                    {
                        total += price * quantity;
                    }
                    else
                    {

                        System.Diagnostics.Debug.WriteLine("Invalid format for Price or Quantity.");
                    }
                }
                TotalLabel.Text = "Total: " + total.ToString("C");
            }
            else
            {
                TotalLabel.Text = "Your cart is empty!!";
                CartGridView.Visible = false;
                CheckoutButton.Visible = false;
                EmptyCartButton.Visible = false;
            }
        }

        protected void CartGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RemoveItem")
            {
                string productId = e.CommandArgument.ToString();
                DataTable cart = (DataTable)Session["Cart"];


                DataRow[] rows = cart.Select("ProductID = '" + productId + "'");
                if (rows.Length > 0)
                {
                    cart.Rows.Remove(rows[0]);
                }

                // Updates the session
                Session["Cart"] = cart;
                BindCart();
            }
        }

        protected void EmptyCartButton_Click(object sender, EventArgs e)
        {
            if (Session["Cart"] != null)
            {
                Session["Cart"] = null;
                BindCart();
            }
        }

        protected void CheckoutButton_Click(object sender, EventArgs e)
        {

            if (Session["Username"] != null)
            {
                Response.Redirect("~/Checkout.aspx");
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void ContinueShoppingButton_Click(object sender, EventArgs e)
        {

            Response.Redirect("~/Product.aspx");
        }
    }
}
