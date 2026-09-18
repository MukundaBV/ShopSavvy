<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="shopsavvy.OrderDetails" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Order Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 500px;
            margin: 50px auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 15px;
        }
        input, textarea, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .btn {
            display: block;
            width: 100%;
            background: #28a745;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn:hover {
            background: #218838;
        }
        .ack {
            margin-top: 20px;
            padding: 15px;
            background: #e9ffe9;
            border: 1px solid #28a745;
            border-radius: 6px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Enter Your Details</h2>

            <div class="form-group">
                <label for="txtName">Full Name:</label>
                <asp:TextBox ID="txtName" runat="server" required="true"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtAddress">Address:</label>
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" required="true"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtMobile">Mobile No:</label>
                <asp:TextBox ID="txtMobile" runat="server" required="true"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="ddlPayment">Payment Method:</label>
                <asp:DropDownList ID="ddlPayment" runat="server">
                    <asp:ListItem Text="-- Select Payment Method --" Value="" />
                    <asp:ListItem Text="Cash on Delivery" Value="COD" />
                    <asp:ListItem Text="UPI" Value="UPI" />
                    <asp:ListItem Text="Credit/Debit Card" Value="Card" />
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnConfirmOrder" runat="server" Text="Place Order" CssClass="btn" OnClick="btnConfirmOrder_Click" />

            <asp:Panel ID="pnlAck" runat="server" Visible="false" CssClass="ack">
                <asp:Label ID="lblAck" runat="server" Text=""></asp:Label>
                <br />
                <asp:Button ID="btnContinue" runat="server" Text="Continue Order" CssClass="btn" OnClick="btnContinue_Click" />
            </asp:Panel>
        </div>
    </form>
</body>
</html>
