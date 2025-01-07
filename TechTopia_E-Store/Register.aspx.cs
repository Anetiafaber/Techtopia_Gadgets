using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace TechTopia_GroupProject
{
    public partial class Register : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["TechStoreConnection"].ConnectionString;


        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string userName = txtUserName.Text.Trim();
                string password = txtPassword.Text.Trim();
                string role = ddlRole.SelectedValue;

                string passwordHash = HashPassword(password);

                try
                {
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand("INSERT INTO Users (UserName, PasswordHash, Role) VALUES (@UserName, @PasswordHash, @Role)", con);
                        cmd.Parameters.AddWithValue("@UserName", userName);
                        cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                        cmd.Parameters.AddWithValue("@Role", role);

                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            Response.Redirect("~/Login.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Registration failed. Please try again.";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred. Please try again later.";
                }
            }
        }


        private string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}
