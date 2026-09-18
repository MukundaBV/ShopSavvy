<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sellerlogin.aspx.cs" Inherits="shopsavvy.sellerlogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Seller Login | ShopSavvy</title>
    <style>
        body {
            font-family:'Gill Sans MT';
            margin: 0;
            padding-right: 150px;
            display: flex;
            justify-content:right;
            align-items:center;
            height: 100vh;
            background: url('images/adminPage.png') no-repeat center center fixed;
        }

        .container {
            background:none;
            padding: 30px;
            border: none;
            text-align: center;
            width: 360px;
        }
         h1 {
             font-size: 40px;
              margin-bottom: 15px;
              font-weight:bold;
         }

        h2 {
            font-size: 30px;
            margin-bottom: 15px;
        }

        .textbox {
            width: 92%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius:12px;
        }

        .btn {
            display: block;
            width: 100%;
            margin-top: 10px;
            padding: 15px;
            font-size: 14px;
            color:white;
            background:green;
            border: none;
            border-radius:12px;
            cursor: pointer;
            
        }

        .btn:hover {
            background: darkgreen;
        }

        /* Back button styling */
        .btn-back {
            background: #607d8b;
        }

        .btn-back:hover {
            background: #455a64;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>WELCOME BACK</h1>
            <h2>Seller Login</h2>

            <asp:TextBox ID="txtUsername" runat="server" CssClass="textbox" Placeholder="Username"></asp:TextBox><br />
            <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox" TextMode="Password" Placeholder="Password"></asp:TextBox><br />

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-back" OnClick="btnBack_Click" />
        </div>
    </form>
</body>
</html>
