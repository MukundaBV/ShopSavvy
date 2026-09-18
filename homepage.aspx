<<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homepage.aspx.cs" Inherits="shopsavvy.homepage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ShopSavvy - Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            display:flex;
            background:pink; 
        }

        .search-bar {
            margin-bottom: 20px;
        }

        .search-bar input[type="text"] {
            padding: 6px;
            width: 200px;
        }

        .search-bar .btn {
            padding: 6px 12px;
            margin-left: 4px;
            cursor: pointer;
        }

        .products-container {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            min-height: 200px;
            justify-content:center;
        }

        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 12px;
            width: 220px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .product-card img {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: 4px;
        }

        .cart-section {
            margin-top: 30px;
        }

        .ack-panel {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid green;
            background-color: #f0fff0;
        }

        .not-found-panel {
            width: 100%;
            text-align: center;
            color: red;
            font-size: 18px;
            font-weight: bold;
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Search & Back -->
        <div class="search-bar">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search products"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" OnClick="btnBack_Click" />
            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn" OnClick="btnLogout_Click" />
        </div>

        <!-- Product List -->
        <div class="products-container">
            <asp:Repeater ID="rptProducts" runat="server">
                <ItemTemplate>
                    <div class="product-card">
                        <img src='<%# Eval("PhotoUrl") %>' alt="Product" />
                        <h4><%# Eval("ProductName") %></h4>
                        <p>Price: ₹<%# Eval("Price") %></p>
                        <p>Available: <%# Eval("Quantity") %></p>
                        <asp:HiddenField ID="hfProductName" runat="server" Value='<%# Eval("ProductName") %>' />
                        <asp:HiddenField ID="hfPrice" runat="server" Value='<%# Eval("Price") %>' />
                        <asp:HiddenField ID="hfAvailable" runat="server" Value='<%# Eval("Quantity") %>' />
                        <asp:TextBox ID="txtQty" runat="server" Text="1" Width="50px"></asp:TextBox>
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" 
                            CommandName="AddToCart" 
                            OnCommand="btnAddToCart_Command" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- Centered Not Found Message -->
            <asp:Panel ID="pnlNotFound" runat="server" CssClass="not-found-panel" Visible="false">
                <p>❌ Product not found. We will add this product soon! 😊</p>
            </asp:Panel>
        </div>

        <!-- Cart -->
        <div class="cart-section">
            <h3>Your Cart</h3>
            <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" 
                OnRowCommand="gvCart_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ProductName" HeaderText="Product" />
                    <asp:BoundField DataField="Price" HeaderText="Price (₹)" />
                    <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                    <asp:BoundField DataField="Total" HeaderText="Total (₹)" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnRemove" runat="server" Text="Remove" 
                                CommandName="RemoveFromCart" 
                                CommandArgument='<%# Eval("ProductName") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" OnClick="btnPlaceOrder_Click" />
        </div>

        <!-- Acknowledgment -->
        <asp:Panel ID="pnlAck" runat="server" Visible="false" CssClass="ack-panel">
            <asp:Label ID="lblAck" runat="server" />
        </asp:Panel>

    </form>
</body>
</html>
