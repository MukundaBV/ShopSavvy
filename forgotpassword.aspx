<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgotpassword.aspx.cs" Inherits="shopsavvy.forgotpassword" %>

<style>
    /* Center the form in the page */
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    /* Simple card style */
    .reset-card {
        background-color: #ffffff;
        padding: 30px 40px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        text-align: center;
        width: 320px;
    }

    .reset-card h2 {
        margin-bottom: 15px;
        color: #333333;
    }

    .reset-card p {
        font-size: 14px;
        color: #666666;
        margin-bottom: 20px;
    }

    /* Input fields */
    .reset-card input[type=text],
    .reset-card input[type=password] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 14px;
    }

    /* Button */
    .reset-card input[type=submit] {
        width: 100%;
        padding: 10px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    }

    .reset-card input[type=submit]:hover {
        background-color: #0056b3;
    }

    /* Hyperlink */
    .reset-card a {
        display: block;
        margin-top: 15px;
        color: #007BFF;
        text-decoration: none;
    }

    .reset-card a:hover {
        text-decoration: underline;
    }

    /* Message label */
    .reset-card .message {
        margin-bottom: 10px;
        color: red;
    }
</style>

<form id="form1" runat="server">
    <div class="reset-card">
        <h2>Forgot Password?</h2>
        <p>Enter your registered Email  to reset your password</p>

        <asp:Label ID="lblMessage" runat="server" CssClass="message" Text=""></asp:Label>

        <asp:TextBox ID="txtUserOrEmail" runat="server" placeholder="Email"></asp:TextBox>
        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="New Password"></asp:TextBox>
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>

        <asp:Button ID="btnReset" runat="server" Text="Update Password" OnClick="btnReset_Click" />

        <asp:HyperLink ID="lnkBack" runat="server" NavigateUrl="~/loginpage.aspx">Back to Login</asp:HyperLink>
    </div>
</form>
