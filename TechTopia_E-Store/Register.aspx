<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TechTopia_GroupProject.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container py-5">
        <h2 class="text-center mb-4">Register</h2>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                        <div class="form-group">
                            <label for="txtUserName">User Name</label>
                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Enter your username" />
                            <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="txtUserName" 
                                ErrorMessage="User Name is required." CssClass="text-danger" Display="Dynamic" />
                        </div>
                        <div class="form-group mt-3">
                            <label for="txtPassword">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter your password" />
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                                ErrorMessage="Password is required." CssClass="text-danger" Display="Dynamic" />
                        </div>
                        <div class="form-group mt-3">
                            <label for="ddlRole">Role</label>
                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select Role" Value="" />
                                <asp:ListItem Text="Admin" Value="Admin" />
                                <asp:ListItem Text="User" Value="User" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvRole" runat="server" ControlToValidate="ddlRole" 
                                InitialValue="" ErrorMessage="Role is required." CssClass="text-danger" Display="Dynamic" />
                        </div>
                        <div class="text-center mt-4">
                            <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-primary btn-block" Text="Register" OnClick="btnRegister_Click" />
                        </div>
                        <div class="text-center mt-3">
                            <p>If you already have an account, <a href="Login.aspx">Login</a>.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
