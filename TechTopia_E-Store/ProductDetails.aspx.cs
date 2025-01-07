using System;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;

namespace TechTopia_GroupProject
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["TechStoreConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string productId = Request.QueryString["ProductID"];
                if (!string.IsNullOrEmpty(productId))
                {
                    BindProductDetails(productId);
                }
                else
                {
                    Response.Write("ProductID is missing or invalid.");
                }
            }
        }

        private void BindProductDetails(string productId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("SELECT ProductID, ProductName, Price, StockQuantity, Image, LongDescription FROM Products WHERE ProductID = @ProductID", con);
                    cmd.Parameters.AddWithValue("@ProductID", productId);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        imgProduct.Src = ResolveUrl(reader["Image"].ToString()); // For HtmlImage control
                        lblProductName.InnerText = reader["ProductName"].ToString();
                        lblPrice.InnerText = string.Format("{0:C}", reader["Price"]);
                        lblStockQuantity.InnerText = reader["StockQuantity"].ToString();
                        lblDescription.InnerText = reader["LongDescription"].ToString();

                        btnAddToCart.CommandArgument = reader["ProductID"].ToString();
                    }
                    else
                    {
                        Response.Write("Product not found.");
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the error for debugging purposes
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                Response.Write("An error occurred while loading product details.");
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            string productId = ((Button)sender).CommandArgument;

            DataTable cart;
            if (Session["Cart"] == null)
            {
                cart = new DataTable();
                cart.Columns.Add("ProductID");
                cart.Columns.Add("ProductName");
                cart.Columns.Add("Price", typeof(decimal));
                cart.Columns.Add("Quantity", typeof(int));
            }
            else
            {
                cart = (DataTable)Session["Cart"];
            }

            DataRow[] existingRows = cart.Select("ProductID = '" + productId + "'");
            if (existingRows.Length > 0)
            {
                existingRows[0]["Quantity"] = Convert.ToInt32(existingRows[0]["Quantity"]) + 1;
            }
            else
            {
                DataRow newRow = cart.NewRow();
                newRow["ProductID"] = productId;
                newRow["ProductName"] = lblProductName.InnerText;

                // Remove the currency symbol before parsing
                string priceString = lblPrice.InnerText.Replace("$", "").Replace(",", "").Trim();
                decimal price;
                if (decimal.TryParse(priceString, out price))
                {
                    newRow["Price"] = price;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Price format is invalid.");
                    // Handle invalid price format here if necessary
                    return;
                }

                newRow["Quantity"] = 1;
                cart.Rows.Add(newRow);
            }

            Session["Cart"] = cart;
            Response.Redirect("~/Cart.aspx");
        }

        protected void btnBackToProducts_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Product.aspx"); // Redirect to the product listing page
        }
    }
}
