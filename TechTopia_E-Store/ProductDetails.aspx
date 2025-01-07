<%@ Page Title="ProductDetails" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="TechTopia_GroupProject.ProductDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Bootstrap CDN -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome CDN for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />

    <div class="mb-4">
        <!-- Back Arrow -->
        <asp:LinkButton ID="btnBackToProducts" runat="server" CssClass="btn btn-link text-decoration-none" OnClick="btnBackToProducts_Click">
            <i class="fas fa-arrow-left"></i> Back to Products
        </asp:LinkButton>
    </div>

    <h2 class="mb-4">Product Details</h2>

    <div class="row">
        <!-- Product Image Column -->
        <div class="col-md-6">
            <div class="product-image">
                <img id="imgProduct" runat="server" class="img-fluid rounded shadow-sm" alt="Product Image" />
            </div>
        </div>
        <!-- Product Details Column -->
        <div class="col-md-6">
            <div class="product-details">
                <h2 id="lblProductName" runat="server" class="product-title font-weight-bold"></h2>
                <p><b>Price:</b> <span id="lblPrice" runat="server"></span> CAD</p>
                <p><b>Stock Quantity:</b> <span id="lblStockQuantity" runat="server"></span></p>
                <p><b>Description:</b> <span id="lblDescription" runat="server"></span></p>
                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-success btn-lg mt-3" OnClick="btnAddToCart_Click" />
            </div>
        </div>
    </div>

    <!-- Reviews Section -->
    <div class="reviews-section mt-5">
        <h3 class="mb-4">Customer Reviews</h3>
        <ul class="nav nav-tabs" id="reviewTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="reviews-tab" data-toggle="tab" href="#reviews" role="tab" aria-controls="reviews" aria-selected="true">Reviews</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="write-review-tab" data-toggle="tab" href="#write-review" role="tab" aria-controls="write-review" aria-selected="false">Write a Review</a>
            </li>
        </ul>
        <div class="tab-content" id="reviewTabContent">
            <!-- Reviews Tab -->
            <div class="tab-pane fade show active p-3" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                <p>No reviews yet. Be the first to review this product!</p>
            </div>
            <!-- Write a Review Tab -->
            <div class="tab-pane fade p-3" id="write-review" role="tabpanel" aria-labelledby="write-review-tab">
                <asp:TextBox ID="txtReview" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="4" placeholder="Write your review here..."></asp:TextBox>
                <asp:Button ID="btnSubmitReview" runat="server" Text="Submit Review" CssClass="btn btn-primary mt-3" />
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies (Popper.js and jQuery) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</asp:Content>
