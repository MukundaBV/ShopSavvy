<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellerDashboard.aspx.cs" Inherits="ShopSavvy.Web.sellerdashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Seller Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: linear-gradient(to bottom ,lightblue,blue,black);
            display: flex;
            justify-content: center;
            padding-top: 30px;
        }

        form {
            width: 900px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            position: relative;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .top-left {
            display: flex;
            gap: 10px;
        }

        #btnLogout {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #ff6b6b;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #btnLogout:hover {
            background-color: #ee5253;
        }

        .section {
            margin: 25px 0;
        }

        .section h3 {
            margin-bottom: 20px;
            color: #333333;
            border-bottom: 2px solid #e0e0e0;
            padding-bottom: 5px;
        }

        .inventory-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            justify-items: center;
        }

        .inventory-item {
            border: 1px solid #ddd;
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            background-color: #fefefe;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .inventory-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }

        .inventory-item img {
            margin-bottom: 10px;
            border-radius: 8px;
            width: 120px;
            height: 120px;
            object-fit: cover;
        }

        .hidden-panel {
            display: none;
            border: 1px solid #aaa;
            padding: 15px;
            margin-top: 10px;
            background: #f9f9f9;
            border-radius: 8px;
            text-align: left;
        }

        label, input, select, .aspNetLabel, .aspNetTextBox, .aspNetButton {
            display: block;
            margin: 8px auto;
        }

        input[type=text], input[type=file], input[type=number], select, .aspNetTextBox {
            width: 60%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type=submit], button, .aspNetButton {
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        input[type=submit]:hover, button:hover, .aspNetButton:hover {
            background-color: #45a049;
        }

        hr {
            margin: 30px 0;
            border: none;
            border-top: 1px solid #ccc;
        }

        a, .aspNetHyperLink {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover, .aspNetHyperLink:hover {
            text-decoration: underline;
        }

        .message-label {
            color: red;
            margin: 10px 0;
            display: block;
        }
    </style>
    <script type="text/javascript">
        function togglePanel(panelId) {
            document.getElementById("pnlAccount").style.display = "none";
            document.getElementById("pnlFAQ").style.display = "none";

            if (panelId) {
                document.getElementById(panelId).style.display = "block";
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="top-bar">
            <div class="top-left">
                <asp:DropDownList ID="ddlHome" runat="server" AutoPostBack="true" 
                    OnSelectedIndexChanged="ddlHome_SelectedIndexChanged">
                    <asp:ListItem Text="-- Select --" Value=""></asp:ListItem>
                    <asp:ListItem Text="Account Details" Value="account"></asp:ListItem>
                    <asp:ListItem Text="Monthly Sales" Value="sales"></asp:ListItem>
                    <asp:ListItem Text="FAQ" Value="faq"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />
        </div>

        <div id="pnlAccount" class="hidden-panel">
            <h3>Account Details</h3>
            <p><b>User Name:</b> demoUser</p>
            <p><b>Password:</b> demoPass123</p>
        </div>

        <div id="pnlFAQ" class="hidden-panel">
            <h3>Frequently Asked Questions</h3>
            <p><b>Q:</b> How to add a product?<br /><b>A:</b> Fill the form and click "Add Product".</p>
            <p><b>Q:</b> How to update stock?<br /><b>A:</b> Re-add product with the same name, it updates quantity.</p>
            <p><b>Q:</b> Can I delete a product?<br /><b>A:</b> Yes, click the "Delete" button under the item.</p>
        </div>

        <hr />

        <div class="section">
            <h3>Add Product</h3>
            <asp:Label ID="lblName" runat="server" Text="Product Name:" />
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>

            <asp:Label ID="lblPrice" runat="server" Text="Price:" />
            <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>

            <asp:Label ID="lblQuantity" runat="server" Text="Quantity:" />
            <asp:TextBox ID="txtQuantity" runat="server"></asp:TextBox>

            <asp:Label ID="lblPhoto" runat="server" Text="Photo:" />
            <asp:FileUpload ID="filePhoto" runat="server" />

            <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" OnClick="btnAddProduct_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="message-label" />
        </div>

        <hr />

        <div class="section">
            <h3>Inventory</h3>
            <div class="inventory-grid">
                <asp:Repeater ID="rptInventory" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="rptInventory_ItemCommand">
                    <ItemTemplate>
                        <div class="inventory-item">
                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("PhotoUrl") %>' Width="120" Height="120" />
                            <br />
                            <b>Name:</b> <%# Eval("ProductName") %><br />
                            <b>Price:</b> <%# Eval("Price") %><br />
                            <b>Quantity:</b> <%# Eval("Quantity") %><br /><br />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                                CommandName="DeleteItem" CommandArgument='<%# Eval("ProductName") %>' />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="Data Source=MUKUNDA\SQLEXPRESS;Initial Catalog=shopsavvy;Integrated Security=True"
            SelectCommand="SELECT ProductName, Price, Quantity, PhotoUrl FROM Products1">
        </asp:SqlDataSource>
    </form>
</body>
</html>
