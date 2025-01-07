<%@ Page Title="Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="TechTopia_GroupProject.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="container-fluid admin-container-fluid p-0">
            <div class="row admin-row">
                <!-- Sidebar -->
                <div class="bg-admin-nav admin-sidebar">
                    <nav class="navbar navbar-expand-md navbar-dark bg-admin-nav admin-nav">
                        <!-- Sidebar Menu -->
                        <div class="navbar-collapse" id="sidebarMenu">
                            <ul class="navbar-nav flex-column" style="width: 100%;">
                                <li class="nav-item">
                                    <asp:LinkButton ID="btnProductDetails" runat="server" CssClass="nav-link" OnClick="ShowProductDetails">
                                <img src="Images/features.png" alt="Product Details" class="admin-nav-icon" />
                                Product Details
                            </asp:LinkButton>
                                </li>
                                <li class="nav-item">
                                    <asp:LinkButton ID="btnManageCategories" runat="server" CssClass="nav-link" OnClick="ShowManageCategories">
                                <img src="Images/categorization.png" alt="Manage Categories" class="admin-nav-icon" />
                                Manage Categories
                            </asp:LinkButton>
                                </li>
                                <li class="nav-item">
                                    <asp:LinkButton ID="btnManageProducts" runat="server" CssClass="nav-link" OnClick="ShowManageProducts">
                                <img src="Images/product-development.png" alt="Manage Products" class="admin-nav-icon" />
                                Manage Products
                            </asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>

                <!-- Main content area -->
                <div class="col-md-9 admin-main-content" style="margin-left: 2%;">
                    <asp:MultiView ID="MainView" runat="server" ActiveViewIndex="0">
                        <!-- Product Details view -->
                        <asp:View ID="productDetailsView" runat="server">
                            <div class="prdDetailsBox">
                                <h4 class="prdDetailsHeader">Product Details</h4>
                                <div class="categoryContainer">
                                    <div class="categoryInputBox">
                                        <asp:Label runat="server" CssClass="categoryLabel">Choose a Category</asp:Label>
                                        <asp:DropDownList ID="ddlCategory1" runat="server" AutoPostBack="True"
                                            DataTextField="CategoryName" DataSourceID="SqlDataSource1"
                                            DataValueField="CategoryID" CssClass="form-control"
                                            AppendDataBoundItems="true">
                                            <asp:ListItem Text="Select a Category" Value="None" Selected="True"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:TechStoreConnection %>"
                                            SelectCommand="SELECT [CategoryID], [CategoryName] FROM [Categories]"></asp:SqlDataSource>
                                    </div>
                                </div>

                                <div class="tableContainer">
                                    <asp:DataList ID="dlProducts" runat="server"
                                        DataKeyField="ProductID" DataSourceID="SqlDataSource2"
                                        CssClass="table table-bordered table-striped">
                                        <HeaderTemplate>
                                            <div class="data-list-header">
                                                <span class="col-xs-3">ID</span>
                                                <span class="col-xs-3">Name</span>
                                                <span class="col-xs-3 text-center">Unit Price</span>
                                                <span class="col-xs-3 text-center">Stock Available</span>
                                            </div>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div class="data-list-item">
                                                <asp:Label ID="lblID" runat="server"
                                                    Text='<%# Eval("ProductID") %>' CssClass="col-xs-3 data-list-column" />
                                                <asp:Label ID="lblName" runat="server"
                                                    Text='<%# Eval("ProductName") %>' CssClass="col-xs-3 data-list-column" />
                                                <asp:Label ID="lblUnitPrice" runat="server"
                                                    Text='<%# Eval("Price", "{0:C}") %>' CssClass="col-xs-3 text-center data-list-column" />
                                                <asp:Label ID="lblOnHand" runat="server"
                                                    Text='<%# Eval("StockQuantity") %>' CssClass="col-xs-3 text-center data-list-column" />
                                            </div>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="table-dark" />
                                    </asp:DataList>

                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:TechStoreConnection %>"
                                        SelectCommand="SELECT [ProductID], [ProductName], [Price], [CategoryID], [StockQuantity], [Image], [ShortDescription], [LongDescription] FROM [Products] WHERE ([CategoryID] = @CategoryID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlCategory1" Name="CategoryID"
                                                PropertyName="SelectedValue" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </div>
                            </div>
                        </asp:View>

                        <!-- Manage Categories view -->
                        <asp:View ID="manageCategoriesView" runat="server">
                            <div class="categoryMaintainBox">
                                <h4 class="categoryMaintainHeader">Manage Categories</h4>
                                <asp:GridView ID="grdCategories" runat="server"
                                    AutoGenerateColumns="False" DataKeyNames="CategoryID"
                                    DataSourceID="SqlDataSource3" AllowSorting="True"
                                    CssClass="table table-bordered table-condensed table-hover table-striped"
                                    OnPreRender="grdCategories_PreRender"
                                    OnRowDeleted="grdCategories_RowDeleted"
                                    OnRowUpdated="grdCategories_RowUpdated">
                                    <Columns>
                                        <asp:BoundField DataField="CategoryID" HeaderText="ID"
                                            ReadOnly="True" SortExpression="CategoryID">
                                            <ItemStyle CssClass="col-xs-1" />
                                            <HeaderStyle CssClass="columnHeader" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CategoryName" HeaderText="Category Name"
                                            SortExpression="CategoryName">
                                            <ItemStyle CssClass="col-xs-3" />
                                            <HeaderStyle CssClass="columnHeader" />
                                        </asp:BoundField>
                                        <asp:CommandField CausesValidation="False" ShowEditButton="True">
                                            <ItemStyle CssClass="col-xs-1 editBtn" />
                                        </asp:CommandField>
                                        <asp:CommandField CausesValidation="False" ShowDeleteButton="True">
                                            <ItemStyle CssClass="col-xs-1 deleteBtn" />
                                        </asp:CommandField>
                                    </Columns>
                                    <HeaderStyle CssClass="table-dark" />
                                    <AlternatingRowStyle CssClass="altRow" />
                                    <EditRowStyle CssClass="warning" />
                                </asp:GridView>

                                <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:TechStoreConnection %>"
                                    ConflictDetection="CompareAllValues"
                                    OldValuesParameterFormatString="original_{0}"
                                    SelectCommand="SELECT [CategoryID], [CategoryName] FROM [Categories]"
                                    DeleteCommand="DELETE FROM [Categories] WHERE [CategoryID] = @original_CategoryID"
                                    InsertCommand="INSERT INTO [Categories] ([CategoryID], [CategoryName]) VALUES (@CategoryID, @CategoryName)"
                                    UpdateCommand="UPDATE [Categories] SET [CategoryName] = @CategoryName WHERE [CategoryID] = @original_CategoryID">
                                    <DeleteParameters>
                                        <asp:Parameter Name="original_CategoryID" Type="String"></asp:Parameter>
                                        <asp:Parameter Name="original_CategoryName" Type="String"></asp:Parameter>
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="CategoryID" Type="String"></asp:Parameter>
                                        <asp:Parameter Name="CategoryName" Type="String"></asp:Parameter>
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="CategoryName" Type="String"></asp:Parameter>
                                        <asp:Parameter Name="original_CategoryID" Type="String"></asp:Parameter>
                                        <asp:Parameter Name="original_CategoryName" Type="String"></asp:Parameter>
                                    </UpdateParameters>
                                </asp:SqlDataSource>

                            </div>

                            <div class="col-xs-12">
                                <h5>Add New Category</h5>
                                <p>
                                    <asp:Label ID="lblErrorCategory" runat="server" EnableViewState="false"
                                        CssClass="text-danger"></asp:Label>
                                </p>

                                <div class="newCategoryBox">
                                    <div class="form-group">
                                        <label for="txtID" class="">ID</label>
                                        <div class="">
                                            <asp:TextBox ID="txtID" runat="server" MaxLength="10"
                                                CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-offset-3">
                                            <asp:RequiredFieldValidator ID="rfvID" runat="server"
                                                ControlToValidate="txtID" CssClass="text-danger"
                                                ErrorMessage="Category ID is a required field" ValidationGroup="CategoryValidation">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtCategoryName" class="">Category Name</label>
                                        <div class="">
                                            <asp:TextBox ID="txtCategoryName" runat="server" MaxLength="15"
                                                CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-offset-2">
                                            <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server"
                                                ControlToValidate="txtCategoryName" CssClass="text-danger"
                                                ErrorMessage="Category Name is a required field" ValidationGroup="CategoryValidation">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <asp:Button ID="btnAdd" runat="server" Text="Add New Category"
                                        CssClass="btn btn-dark newCategoryBtn" OnClick="btnAdd_Click" ValidationGroup="CategoryValidation" />
                                </div>
                            </div>
                        </asp:View>

                        <!-- Manage Products view -->
                        <asp:View ID="manageProductsView" runat="server">
                            <div class="prdMaintainContainer">
                                <h4 class="prdMaintainHeader">Manage Products</h4>
                                <div class="prdMaintainBox">
                                    <div class="col-sm-6 table-responsive">
                                        <asp:GridView ID="grdProducts" runat="server" SelectedIndex="0"
                                            AutoGenerateColumns="False" DataKeyNames="ProductID"
                                            DataSourceID="SqlDataSource4" AllowPaging="True" AllowSorting="True"
                                            CssClass="table table-bordered table-striped table-condensed"
                                            OnPreRender="grdProducts_PreRender">
                                            <Columns>
                                                <asp:BoundField DataField="ProductID" HeaderText="ID"
                                                    ReadOnly="True" SortExpression="ProductID">
                                                    <ItemStyle CssClass="col-xs-2" />
                                                    <HeaderStyle CssClass="columnHeader" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ProductName" HeaderText="Name" SortExpression="ProductName">
                                                    <ItemStyle CssClass="col-xs-6" />
                                                    <HeaderStyle CssClass="columnHeader" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CategoryID" HeaderText="Category" SortExpression="CategoryID">
                                                    <ItemStyle CssClass="col-xs-3" />
                                                    <HeaderStyle CssClass="columnHeader" />
                                                </asp:BoundField>
                                                <asp:CommandField ButtonType="Link" ShowSelectButton="true">
                                                    <ItemStyle CssClass="col-xs-1 selectBtn" />
                                                </asp:CommandField>
                                            </Columns>
                                            <HeaderStyle CssClass="table-dark" />
                                            <PagerSettings Mode="NumericFirstLast" />
                                            <PagerStyle CssClass="pagerStyle"
                                                BackColor="black" ForeColor="white" HorizontalAlign="Center" />
                                            <SelectedRowStyle CssClass="warning" />
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="SqlDataSource4" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:TechStoreConnection %>"
                                            SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [Price], [StockQuantity] FROM [Products] ORDER BY [ProductName]"></asp:SqlDataSource>
                                    </div>

                                    <div class="col-sm-6">
                                        <asp:DetailsView ID="dvProduct" runat="server"
                                            DataSourceID="SqlDataSource5" DataKeyNames="ProductID"
                                            AutoGenerateRows="False"
                                            CssClass="table table-bordered table-condensed"
                                            OnItemDeleted="dvProduct_ItemDeleted"
                                            OnItemDeleting="dvProduct_ItemDeleting"
                                            OnItemInserted="dvProduct_ItemInserted"
                                            OnItemUpdated="dvProduct_ItemUpdated">
                                            <Fields>
                                                <asp:TemplateField HeaderText="Product ID">
                                                    <EditItemTemplate>
                                                        <asp:Label runat="server" ID="lblProductID"
                                                            Text='<%# Eval("ProductID") %>'></asp:Label>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <div class="col-xs-11 col-insert">
                                                            <asp:TextBox runat="server" ID="txtProductID"
                                                                Text='<%# Bind("ProductID") %>' MaxLength="10"
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvProductID" runat="server"
                                                            ControlToValidate="txtProductID" CssClass="text-danger"
                                                            ErrorMessage="ProductID is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblProductID"
                                                            Text='<%# Bind("ProductID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle CssClass="col-xs-4" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Name">
                                                    <EditItemTemplate>
                                                        <div class="col-xs-11 col-edit">
                                                            <asp:TextBox runat="server" ID="txtProductName"
                                                                Text='<%# Bind("ProductName") %>' MaxLength="50"
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvProductName" runat="server"
                                                            ControlToValidate="txtProductName" CssClass="text-danger"
                                                            ErrorMessage="Product Name is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <div class="col-xs-11 col-insert">
                                                            <asp:TextBox runat="server" ID="txtProductName"
                                                                Text='<%# Bind("ProductName") %>' MaxLength="50"
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvProductName" runat="server"
                                                            ControlToValidate="txtProductName" CssClass="text-danger"
                                                            ErrorMessage="Product Name is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblProductName"
                                                            Text='<%# Bind("ProductName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ShortDescription">
                                                    <EditItemTemplate>
                                                        <div class="col-xs-11 col-edit">
                                                            <asp:TextBox runat="server" ID="txtShortDesc"
                                                                Text='<%# Bind("ShortDescription") %>' MaxLength="250"
                                                                TextMode="MultiLine" Rows="4"
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvShortDesc" runat="server"
                                                            ControlToValidate="txtShortDesc" CssClass="text-danger"
                                                            ErrorMessage="Short Description is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <div class="col-xs-11 col-insert">
                                                            <asp:TextBox runat="server" ID="txtShortDesc"
                                                                Text='<%# Bind("ShortDescription") %>' MaxLength="250"
                                                                TextMode="MultiLine" Rows="4"
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvShortDesc" runat="server"
                                                            ControlToValidate="txtShortDesc" CssClass="text-danger"
                                                            ErrorMessage="Short Description is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblShortDesc"
                                                            Text='<%# Bind("ShortDescription") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="LongDescription">
                                                    <EditItemTemplate>
                                                        <div class="col-xs-11 col-edit">
                                                            <asp:TextBox runat="server" ID="txtLongDesc"
                                                                Text='<%# Bind("LongDescription") %>'
                                                                TextMode="MultiLine" Rows="4"
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvLongDesc" runat="server"
                                                            ControlToValidate="txtLongDesc" CssClass="text-danger"
                                                            ErrorMessage="Long Description is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <div class="col-xs-11 col-insert">
                                                            <asp:TextBox runat="server" ID="txtLongDesc"
                                                                Text='<%# Bind("LongDescription") %>'
                                                                TextMode="MultiLine" Rows="4"
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvLongDesc" runat="server"
                                                            ControlToValidate="txtLongDesc" CssClass="text-danger"
                                                            ErrorMessage="Long Description is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblLongDesc"
                                                            Text='<%# Bind("LongDescription") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Category">
                                                    <EditItemTemplate>
                                                        <div class="col-xs-11 col-edit">
                                                            <asp:DropDownList runat="server" ID="ddlCategory2"
                                                                DataSourceID="SqlDataSource6"
                                                                DataTextField="CategoryName" DataValueField="CategoryID"
                                                                SelectedValue='<%# Bind("CategoryID") %>'
                                                                CssClass="form-control">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <div class="col-xs-11 col-insert">
                                                            <asp:DropDownList runat="server" ID="ddlCategory2"
                                                                DataSourceID="SqlDataSource6"
                                                                DataTextField="CategoryName" DataValueField="CategoryID"
                                                                SelectedValue='<%# Bind("CategoryID") %>'
                                                                CssClass="form-control">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblCategory"
                                                            Text='<%# Bind("CategoryID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Image">
                                                    <EditItemTemplate>
                                                        <div class="col-xs-11 col-edit">
                                                            <asp:TextBox runat="server" ID="txtImage"
                                                                Text='<%# Bind("Image") %>' MaxLength="30"
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <div class="col-xs-11 col-insert">
                                                            <asp:TextBox runat="server" ID="txtImage"
                                                                Text='<%# Bind("Image") %>' MaxLength="30"
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblImage"
                                                            Text='<%# Bind("Image") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Price">
                                                    <EditItemTemplate>
                                                        <div class="col-xs-11 col-edit">
                                                            <asp:TextBox runat="server" ID="txtPrice"
                                                                Text='<%# Bind("Price") %>'
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server"
                                                            ControlToValidate="txtPrice" CssClass="text-danger"
                                                            ErrorMessage="Price is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:CompareValidator ID="cvPrice" runat="server"
                                                            ControlToValidate="txtPrice" Type="Double" Operator="GreaterThan"
                                                            ErrorMessage="Price must be a decimal value greater than 0." Text="*"
                                                            CssClass="text-danger" ValueToCompare="0.00" ValidationGroup="ProductValidation"></asp:CompareValidator>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <div class="col-xs-11 col-insert">
                                                            <asp:TextBox runat="server" ID="txtPrice"
                                                                Text='<%# Bind("Price") %>'
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server"
                                                            ControlToValidate="txtPrice" CssClass="text-danger"
                                                            ErrorMessage="Price is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:CompareValidator ID="cvPrice" runat="server"
                                                            ControlToValidate="txtPrice" CssClass="text-danger"
                                                            Type="Currency" Operator="DataTypeCheck"
                                                            ErrorMessage="Price must be numeric." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:CompareValidator>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblPrice"
                                                            Text='<%# Bind("Price", "{0:C}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Stock Quantity">
                                                    <EditItemTemplate>
                                                        <div class="col-xs-11 col-edit">
                                                            <asp:TextBox runat="server" ID="txtStockQuantity"
                                                                Text='<%# Bind("StockQuantity") %>'
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvStockQuantity" runat="server"
                                                            ControlToValidate="txtStockQuantity" CssClass="text-danger"
                                                            ErrorMessage="Stock Quantity is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:CompareValidator ID="cvStockQuantity" runat="server"
                                                            ControlToValidate="txtStockQuantity" CssClass="text-danger"
                                                            Type="Integer" Operator="DataTypeCheck"
                                                            ErrorMessage="Stock Quantity must be numeric." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:CompareValidator>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <div class="col-xs-11 col-insert">
                                                            <asp:TextBox runat="server" ID="txtStockQuantity"
                                                                Text='<%# Bind("StockQuantity") %>'
                                                                CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfvStockQuantity" runat="server"
                                                            ControlToValidate="txtStockQuantity" CssClass="text-danger"
                                                            ErrorMessage="Stock Quantity is a required field." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:CompareValidator ID="cvQuantityStock" runat="server"
                                                            ControlToValidate="txtStockQuantity" CssClass="text-danger"
                                                            Type="Integer" Operator="DataTypeCheck"
                                                            ErrorMessage="Stock Quantity must be numeric." Text="*" ValidationGroup="ProductValidation">
                                                        </asp:CompareValidator>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblStockQuantity"
                                                            Text='<%# Bind("StockQuantity") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:CommandField ItemStyle-CssClass="actionBtn" ButtonType="Link" ShowDeleteButton="true" ShowEditButton="true" ShowInsertButton="true" ValidationGroup="ProductValidation" />
                                            </Fields>
                                            <RowStyle BackColor="#e7e7e7" />
                                            <CommandRowStyle BackColor="black" ForeColor="white" />
                                        </asp:DetailsView>
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:TechStoreConnection %>"
                                            ConflictDetection="CompareAllValues"
                                            OldValuesParameterFormatString="original_{0}"
                                            SelectCommand="SELECT [ProductID], [ProductName], [ShortDescription], [LongDescription], [CategoryID], [Image], [Price], [StockQuantity] FROM [Products] WHERE ([ProductID] = @ProductID)"
                                            DeleteCommand="DELETE FROM [Products] WHERE [ProductID] = @original_ProductID AND [ProductName] = @original_ProductName AND [ShortDescription] = @original_ShortDescription AND [LongDescription] = @original_LongDescription AND [CategoryID] = @original_CategoryID 
                            AND (([Image] = @original_Image) OR ([Image] IS NULL AND @original_Image IS NULL)) AND [Price] = @original_Price AND [StockQuantity] = @original_StockQuantity"
                                            InsertCommand="INSERT INTO [Products] ([ProductID], [ProductName], [ShortDescription], [LongDescription], [CategoryID], [Image], [Price], [StockQuantity]) VALUES (@ProductID, @ProductName, @ShortDescription, @LongDescription,
                            @CategoryID, @Image, @Price, @StockQuantity)"
                                            UpdateCommand="UPDATE [Products] SET [ProductName] = @ProductName, [ShortDescription] = @ShortDescription, [LongDescription] = @LongDescription, [CategoryID] = @CategoryID, [Image] = @Image, [Price] = @Price, [StockQuantity] = @StockQuantity 
                            WHERE [ProductID] = @original_ProductID AND [ProductName] = @original_ProductName AND [ShortDescription] = @original_ShortDescription AND [LongDescription] = @original_LongDescription AND [CategoryID] = @original_CategoryID 
                            AND (([Image] = @original_Image) OR ([Image] IS NULL AND @original_Image IS NULL)) AND [Price] = @original_Price AND [StockQuantity] = @original_StockQuantity">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="grdProducts" Name="ProductID"
                                                    PropertyName="SelectedValue" Type="String" />
                                            </SelectParameters>
                                            <DeleteParameters>
                                                <asp:Parameter Name="original_ProductID" Type="String" />
                                                <asp:Parameter Name="original_ProductName" Type="String" />
                                                <asp:Parameter Name="original_ShortDescription" Type="String" />
                                                <asp:Parameter Name="original_LongtDescription" Type="String" />
                                                <asp:Parameter Name="original_CategoryID" Type="String" />
                                                <asp:Parameter Name="original_Image" Type="String" />
                                                <asp:Parameter Name="original_Price" Type="Decimal" />
                                                <asp:Parameter Name="original_StockQuantity" Type="Int32" />
                                            </DeleteParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="ProductName" Type="String" />
                                                <asp:Parameter Name="ShortDescription" Type="String" />
                                                <asp:Parameter Name="LongDescription" Type="String" />
                                                <asp:Parameter Name="CategoryID" Type="String" />
                                                <asp:Parameter Name="Image" Type="String" />
                                                <asp:Parameter Name="Price" Type="Decimal" />
                                                <asp:Parameter Name="StockQuantity" Type="Int32" />
                                                <asp:Parameter Name="original_ProductID" Type="String" />
                                                <asp:Parameter Name="original_ProductName" Type="String" />
                                                <asp:Parameter Name="original_ShortDescription" Type="String" />
                                                <asp:Parameter Name="original_LongDescription" Type="String" />
                                                <asp:Parameter Name="original_CategoryID" Type="String" />
                                                <asp:Parameter Name="original_Image" Type="String" />
                                                <asp:Parameter Name="original_Price" Type="Decimal" />
                                                <asp:Parameter Name="original_StockQuantity" Type="Int32" />
                                            </UpdateParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="ProductID" Type="String" />
                                                <asp:Parameter Name="ProductName" Type="String" />
                                                <asp:Parameter Name="ShortDescription" Type="String" />
                                                <asp:Parameter Name="LongDescription" Type="String" />
                                                <asp:Parameter Name="CategoryID" Type="String" />
                                                <asp:Parameter Name="Image" Type="String" />
                                                <asp:Parameter Name="Price" Type="Decimal" />
                                                <asp:Parameter Name="StockQuantity" Type="Int32" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="SqlDataSource6" runat="server"
                                            ConnectionString='<%$ ConnectionStrings:TechStoreConnection %>'
                                            SelectCommand="SELECT [CategoryID], [CategoryName] FROM [Categories] ORDER BY [CategoryName]"></asp:SqlDataSource>

                                        <p>
                                            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                                                HeaderText="Please correct the following errors:"
                                                CssClass="text-danger" ValidationGroup="ProductValidation" />
                                        </p>

                                        <p>
                                            <asp:Label ID="lblErrorProduct" runat="server" EnableViewState="false"
                                                CssClass="text-danger"></asp:Label>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                    </asp:MultiView>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
