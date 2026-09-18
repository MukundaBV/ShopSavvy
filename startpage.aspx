<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="startpage.aspx.cs" Inherits="shopsavvy.startpage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Welcome | ShopSavvy Mini Project</title>
    <style>
        /* Use system fonts for offline compatibility */
        body {
            font-family: Cambria, Cochin, Georgia, Times, Times New Roman, serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            /* Local AI-generated background image */
            background: url('images/envato-labs-ai-c328f531-bfa5-4d92-946e-fec14c2a57ab.jpg') no-repeat center center fixed;
            background-size: cover;
            text-align: center;
            position: relative;
        }

        /* Overlay for readability */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 0;
        }

        .content {
            position: relative;
            z-index: 1;
            max-width: 700px;
            padding: 30px;
            border-radius: 12px;
            background:  none;
        }

        h1 {
            font-weight: bold;
            font-size: 48px;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            margin: 10px 12px;
            padding: 14px 30px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-transform: uppercase;
            transition: all 0.3s ease;
        }

        .btn-register { background: #28a745; }
        .btn-login { background: #0078d7; }
        .btn-seller { background: #ff5722; }

        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="content">
            <h1>Welcome to ShopSavvy</h1>
            <p>Explore our mini e-commerce project developed using ASP.NET and SQL Server.</p>

            <asp:Button ID="btnRegister" runat="server" Text="New User? Register" CssClass="btn btn-register" OnClick="btnRegister_Click" />
            <asp:Button ID="btnLogin" runat="server" Text="Existing User? Login" CssClass="btn btn-login" OnClick="btnLogin_Click" />
            <asp:Button ID="btnSellerLogin" runat="server" Text="Seller Login" CssClass="btn btn-seller" OnClick="btnSellerLogin_Click" />
        </div>
    </form>
</body>
</html>