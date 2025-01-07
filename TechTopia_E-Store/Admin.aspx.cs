using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TechTopia_GroupProject
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is logged in
            if (Session["Username"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                // No user logged in or user is not an admin, redirect to login page
                Response.Redirect("Login.aspx");
            }
            else
            {
                // Admin user is logged in, proceed with normal page load
                if (!IsPostBack)
                {
                    HighlightNavItem(btnProductDetails);
                }
            }
        }
        protected void ShowProductDetails(object sender, EventArgs e)
        {
            MainView.ActiveViewIndex = 0;
            HighlightNavItem(btnProductDetails);
        }

        protected void ShowManageCategories(object sender, EventArgs e)
        {
            MainView.ActiveViewIndex = 1;
            HighlightNavItem(btnManageCategories);
        }

        protected void ShowManageProducts(object sender, EventArgs e)
        {
            MainView.ActiveViewIndex = 2;
            HighlightNavItem(btnManageProducts);
        }

        private void HighlightNavItem(LinkButton selectedButton)
        {
            // Clear previous highlights
            btnProductDetails.CssClass = "nav-link";
            btnManageCategories.CssClass = "nav-link";
            btnManageProducts.CssClass = "nav-link";

            // Add highlight to the selected button
            selectedButton.CssClass += " selected-nav-item";
        }

        // pre render categories table
        protected void grdCategories_PreRender(object sender, EventArgs e)
        {
            grdCategories.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        // validate and insert new category details into db
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                var parameters = SqlDataSource3.InsertParameters;
                parameters["CategoryID"].DefaultValue = txtID.Text;
                parameters["CategoryName"].DefaultValue = txtCategoryName.Text;

                try
                {
                    SqlDataSource3.Insert();
                    txtID.Text = "";
                    txtCategoryName.Text = "";
                }
                catch (Exception ex)
                {
                    lblErrorCategory.Text = DatabaseErrorMessage(ex.Message);
                }
            }
        }

        // exception handling for categories updation
        protected void grdCategories_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblErrorCategory.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
            }
            else if (e.AffectedRows == 0)
            {
                lblErrorCategory.Text = ConcurrencyErrorMessage();
            }
        }

        // exception handling for categories deletion
        protected void grdCategories_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblErrorCategory.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
            }
            else if (e.AffectedRows == 0)
            {
                lblErrorCategory.Text = ConcurrencyErrorMessage();
            }
        }

        // show database error message in UI
        private string DatabaseErrorMessage(string errorMsg)
        {
            return $"<b>A database error has occurred:</b> {errorMsg}";
        }
        private string ConcurrencyErrorMessage()
        {
            return "Another user may have updated that category. Please try again";
        }

        // products table pre rendering
        protected void grdProducts_PreRender(object sender, EventArgs e)
        {
            grdProducts.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        // exception handling for products table updation
        protected void dvProduct_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblErrorProduct.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
            }
            else if (e.AffectedRows == 0)
                lblErrorProduct.Text = ConcurrencyErrorMessage();
            else
                grdProducts.DataBind();
        }

        // exception handling for products table item deletion
        protected void dvProduct_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblErrorProduct.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
            }
            else if (e.AffectedRows == 0)
                lblErrorProduct.Text = ConcurrencyErrorMessage();
            else
                grdProducts.DataBind();
        }

        // exception handling for products table insertion
        protected void dvProduct_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblErrorProduct.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
                e.KeepInInsertMode = true;
            }
            else
                grdProducts.DataBind();
        }

        // formatting product price on deletion from table
        protected void dvProduct_ItemDeleting(object sender, DetailsViewDeleteEventArgs e)
        {
            if (e.Values["Price"] != null)
                e.Values["Price"] =
                    e.Values["Price"].ToString().Substring(1);
        }
    }
}