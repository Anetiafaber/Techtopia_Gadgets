<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="TechTopia_GroupProject.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <style>
        .checkout-form {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
        }

        .form-section {
            margin-bottom: 20px;
        }

        .form-section h3 {
            margin-bottom: 15px;
        }
    </style>

    <div class="container py-5">
        <h2 class="text-center mb-4">Checkout</h2>

        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="checkout-form">
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mb-4" />

                    <asp:Panel ID="ContactInfoPanel" runat="server" CssClass="form-section">
                        <h3>Contact Information</h3>
                        <div class="form-group">
                            <label for="txtEmail">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ValidationGroup="PlaceOrderValidation" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Email Address is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Invalid email format." CssClass="text-danger" Display="Dynamic"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ValidationGroup="PlaceOrderValidation" />
                        </div>
                        <div class="form-group">
                            <label for="txtEmailRetry">Retype Email Address</label>
                            <asp:TextBox ID="txtEmailRetry" runat="server" CssClass="form-control" ValidationGroup="PlaceOrderValidation" />
                            <asp:RequiredFieldValidator ID="rfvEmailRetry" runat="server" ControlToValidate="txtEmailRetry"
                                ErrorMessage="Retyped Email Address is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                            <asp:CompareValidator ID="cvEmail" runat="server" ControlToCompare="txtEmail"
                                ControlToValidate="txtEmailRetry" ErrorMessage="Email addresses do not match." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                        </div>
                        <div class="form-group">
                            <label for="txtFirstName">First Name</label>
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" ValidationGroup="PlaceOrderValidation" />
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                                ErrorMessage="First Name is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                        </div>
                        <div class="form-group">
                            <label for="txtLastName">Last Name</label>
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" ValidationGroup="PlaceOrderValidation" />
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName"
                                ErrorMessage="Last Name is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                        </div>
                        <div class="form-group">
                            <label for="txtPhone">Phone Number</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" ValidationGroup="PlaceOrderValidation" />
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone"
                                ErrorMessage="Phone Number is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="BillingAddressPanel" runat="server" CssClass="form-section">
                        <h3>Billing Address</h3>
                        <div class="form-group">
                            <label for="txtAddress">Address</label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" ValidationGroup="PlaceOrderValidation" />
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress"
                                ErrorMessage="Address is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                        </div>
                        <div class="form-group">
                            <label for="txtCity">City</label>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" ValidationGroup="PlaceOrderValidation" />
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity"
                                ErrorMessage="City is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                        </div>
                        <div class="form-group">
                            <label for="ddlState">State/Province</label>
                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" ValidationGroup="PlaceOrderValidation">
                                <asp:ListItem Text="Select a state/province" Value="" />
                                <asp:ListItem Text="Alberta" Value="AB" />
                                <asp:ListItem Text="British Columbia" Value="BC" />
                                <asp:ListItem Text="Manitoba" Value="MB" />
                                <asp:ListItem Text="New Brunswick" Value="NB" />
                                <asp:ListItem Text="Newfoundland and Labrador" Value="NL" />
                                <asp:ListItem Text="Northwest Territories" Value="NT" />
                                <asp:ListItem Text="Nova Scotia" Value="NS" />
                                <asp:ListItem Text="Nunavut" Value="NU" />
                                <asp:ListItem Text="Ontario" Value="ON" />
                                <asp:ListItem Text="Prince Edward Island" Value="PE" />
                                <asp:ListItem Text="Quebec" Value="QC" />
                                <asp:ListItem Text="Saskatchewan" Value="SK" />
                                <asp:ListItem Text="Yukon" Value="YT" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="ddlState"
                                InitialValue="" ErrorMessage="State/Province is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                        </div>
                        <div class="form-group">
                            <label for="txtZipcode">Zip Code</label>
                            <asp:TextBox ID="txtZipcode" runat="server" CssClass="form-control" ValidationGroup="PlaceOrderValidation" />
                            <asp:RequiredFieldValidator ID="rfvZipcode" runat="server" ControlToValidate="txtZipcode"
                                ErrorMessage="Zip Code is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="PlaceOrderValidation" />
                            <asp:RegularExpressionValidator ID="revZipcode" runat="server" ControlToValidate="txtZipcode"
                                ErrorMessage="Invalid zip code format." CssClass="text-danger" Display="Dynamic"
                                ValidationExpression="^\d{5}(-\d{4})?$" ValidationGroup="PlaceOrderValidation" />
                        </div>
                    </asp:Panel>

                    <div class="d-flex justify-content-between">
                        <asp:Button ID="btnGoToCart" runat="server" CssClass="btn btn-secondary" Text="Go to Cart" OnClick="btnGoToCart_Click" />
                        <asp:Button ID="btnPlaceOrder" runat="server" CssClass="btn btn-primary" Text="Place Order" OnClick="btnPlaceOrder_Click" ValidationGroup="PlaceOrderValidation" />  
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</asp:Content>
