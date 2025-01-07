<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="TechTopia_GroupProject.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">       
        <div class="row">
            <div class="col">
                <h2 class="text-center mb-4">Shopping Cart</h2>
                <hr class="mb-5">
            </div>
        </div>
        <div class="row">
            <div class="col">
                <asp:GridView ID="CartGridView" runat="server" AutoGenerateColumns="False" 
                              OnRowCommand="CartGridView_RowCommand" DataKeyNames="ProductID" 
                              CssClass="table table-striped table-hover text-center align-middle">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="RemoveButton" runat="server" Text="Remove" 
                                            CommandName="RemoveItem" CommandArgument='<%# Eval("ProductID") %>' 
                                            CssClass="btn btn-outline-danger btn-sm" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

<div class="row mt-4">
    <div class="col text-center">  
        <div class="mb-5"> 
            <h5 class="d-inline-block"></h5>
            <asp:Label ID="TotalLabel" runat="server" Font-Bold="True" CssClass="h4 text-black ms-2"></asp:Label>
        </div>
       
        <div class="d-flex justify-content-center mt-3"> 
            <asp:Button ID="ContinueShoppingButton" runat="server" Text="Continue Shopping" 
                        PostBackUrl="~/Product.aspx" CssClass="btn btn-outline-primary me-5" />

            <asp:Button ID="EmptyCartButton" runat="server" Text="Empty Cart" 
                        OnClick="EmptyCartButton_Click" CssClass="btn btn-outline-warning me-5" />

            <asp:Button ID="CheckoutButton" runat="server" Text="Checkout" 
                        OnClick="CheckoutButton_Click" CssClass="btn btn-outline-success" />
        </div>
    </div>
</div>

    </div>
</asp:Content>
