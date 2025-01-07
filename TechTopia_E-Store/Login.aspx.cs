using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace TechTopia_GroupProject
{
    public partial class Login : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["TechStoreConnection"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string userName = txtUserName.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand("SELECT Role, PasswordHash FROM Users WHERE UserName = @UserName", con);
                        cmd.Parameters.AddWithValue("@UserName", userName);

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            string storedPasswordHash = reader["PasswordHash"].ToString();
                            string role = reader["Role"].ToString();

                            if (VerifyPassword(password, storedPasswordHash))
                            {
                                Session["Username"] = userName;
                                Session["Role"] = role;

                                if (role.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                                {
                                    Response.Redirect("~/Admin.aspx");
                                }
                                else
                                {
                                    Response.Redirect("~/Product.aspx");
                                }
                            }
                            else
                            {
                                lblMessage.Text = "Invalid username or password.";
                            }
                        }
                        else
                        {
                            lblMessage.Text = "Invalid username or password.";
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception (not shown)
                    lblMessage.Text = "An error occurred. Please try again later.";
                }
            }
        }

        private bool VerifyPassword(string password, string storedPasswordHash)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString() == storedPasswordHash;
            }
        }
    }
}
