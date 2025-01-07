<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TechTopia_GroupProject.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container py-5">
        <h2 class="text-center mb-4">Login</h2>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                        <div class="form-group">
                            <label for="txtUserName">User Name</label>
                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Enter your username" style="width: 100%;" />
                            <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="txtUserName" 
                                ErrorMessage="User Name is required." CssClass="text-danger" Display="Dynamic" />
                        </div>
                        <div class="form-group mt-3">
                            <label for="txtPassword">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter your password" style="width: 100%;" />
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                                ErrorMessage="Password is required." CssClass="text-danger" Display="Dynamic" />
                        </div>
                        <div class="text-center mt-4">
                            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary btn-block" Text="Login" OnClick="btnLogin_Click" />
                        </div>
                        <div class="text-center mt-3">
                            <p>Don't have an account? <a href="Register.aspx">Register here</a>.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>