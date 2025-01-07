using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace TechTopia_GroupProject
{
    public partial class Product : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["TechStoreConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    string username = Session["Username"].ToString();
                    lblWelcome.Text = $"Welcome, {username}!";
                }
                else
                {
                    lblWelcome.Text = $"Welcome, TechTopia!";
                }
                BindCategoriesAndProducts();
            }
        }

        private void BindCategoriesAndProducts()
        {
            DataSet ds = new DataSet();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Fetch categories
                SqlDataAdapter daCategories = new SqlDataAdapter("SELECT CategoryID, CategoryName FROM Categories", con);
                daCategories.Fill(ds, "Categories");

                // Fetch products
                SqlDataAdapter daProducts = new SqlDataAdapter(
                    "SELECT ProductID, ProductName, Price, StockQuantity, Image, ShortDescription, CategoryID " +
                    "FROM Products", con);
                daProducts.Fill(ds, "Products");

                // Create DataRelation between Categories and Products
                DataRelation relation = new DataRelation("CategoryBooks", ds.Tables["Categories"].Columns["CategoryID"], ds.Tables["Products"].Columns["CategoryID"]);
                ds.Relations.Add(relation);
            }

            // Bind the data to the repeater
            RepeaterCategories.DataSource = ds.Tables["Categories"];
            RepeaterCategories.DataBind();
        }

        protected void btnViewProduct_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string productId = btn.CommandArgument;
            Response.Redirect("ProductDetails.aspx?ProductID=" + productId);
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string productId = btn.CommandArgument;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT ProductID, ProductName, Price FROM Products WHERE ProductID = @ProductID", con);
                cmd.Parameters.AddWithValue("@ProductID", productId);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string productName = reader["ProductName"].ToString();
                    decimal price = Convert.ToDecimal(reader["Price"]);

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
                        newRow["ProductName"] = productName;
                        newRow["Price"] = price;
                        newRow["Quantity"] = 1;
                        cart.Rows.Add(newRow);
                    }

                    Session["Cart"] = cart;

                    // Redirect to Cart page after adding to cart
                    Response.Redirect("~/Cart.aspx");
                }
            }
        }
    }
}
