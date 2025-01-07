<%@ Page Title="Product" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="TechTopia_GroupProject.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Custom CSS to ensure uniform image sizes -->
    <style>
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: contain;
            object-position: center;
            background-color: #f8f9fa;
        }
    </style>

       <div class="container py-3">
        <div class="d-flex justify-content-end">
            <asp:Label ID="lblWelcome" runat="server" CssClass="text-secondary" />
        </div>
    </div>

    <!-- Hero Section -->
    <section class="hero-section text-white text-center py-5" style="background-color: #343a40;">
        <div class="container">
            <h1 class="display-4">Welcome to Our Store!</h1>
            <p class="lead">Discover the best products at unbeatable prices.</p>
            <a href="#featured-products" class="btn btn-primary btn-lg mt-3">Shop Now</a>
        </div>
    </section>

    <!-- Featured Products Section -->
    <section id="featured-products" class="py-5">
        <div class="container">
            <h2 class="text-center mb-4">Featured Products</h2>
            <div class="row">
                <!-- Featured Product Items -->
                <asp:Repeater ID="RepeaterFeaturedProducts" runat="server">
                    <ItemTemplate>
                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <img src='<%# Eval("Image") %>' class="card-img-top product-image" alt='<%# Eval("ProductName") %>'>
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("ProductName") %></h5>
                                    <p class="card-text"><b>Price:</b> <%# Eval("Price", "{0:c}") %> CAD</p>
                                    <p class="card-text"><b>Description:</b> <%# Eval("ShortDescription") %></p>
                                    <asp:Button ID="btnViewProduct" runat="server" Text="View Product" CssClass="btn btn-primary btn-block" CommandArgument='<%# Eval("ProductID") %>' OnClick="btnViewProduct_Click" />
                                    <asp:Button ID="btnBuyNow" runat="server" CssClass="btn btn-success btn-block mt-2" Text="Buy Now" CommandArgument='<%# Eval("ProductID") %>' OnClick="btnBuyNow_Click" />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- Product List Section -->
    <section id="products-list" class="py-5">
        <div class="container">
            <h2 class="mb-4">All Products</h2>
            <asp:Repeater ID="RepeaterCategories" runat="server">
                <ItemTemplate>
                    <div class="category-section mb-5">
                        <h3 class="category-title mb-4"><%# Eval("CategoryName") %></h3>
                        <div class="row">
                            <asp:Repeater ID="RepeaterBooks" runat="server" DataSource='<%# ((System.Data.DataRowView)Container.DataItem).CreateChildView("CategoryBooks") %>'>
                                <ItemTemplate>
                                    <div class="col-md-4 mb-4">
                                        <div class="card h-100">
                                            <img src='<%# Eval("Image") %>' class="card-img-top product-image" alt='<%# Eval("ProductName") %>'>
                                            <div class="card-body">
                                                <h5 class="card-title"><%# Eval("ProductName") %></h5>
                                                <p class="card-text"><b>Price:</b> <%# Eval("Price", "{0:c}") %> CAD</p>
                                                <p class="card-text"><b>Description:</b> <%# Eval("ShortDescription") %></p>
                                                <asp:Button ID="btnViewProduct" runat="server" Text="View Product" CssClass="btn btn-primary btn-block" CommandArgument='<%# Eval("ProductID") %>' OnClick="btnViewProduct_Click" />
                                                <asp:Button ID="btnBuyNow" runat="server" CssClass="btn btn-success btn-block mt-2" Text="Buy Now" CommandArgument='<%# Eval("ProductID") %>' OnClick="btnBuyNow_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</asp:Content>
