<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginpage.aspx.cs" Inherits="shopsavvy.loginpage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ShopSavvy | Login</title>
    <style type="text/css">
        body {
            margin: 0;
            height: 100%; /* changed from 100vh */
            display: block; /* fallback for flex */
            font-family:'Gill Sans MT';
            background: url('images/loginPage.jpg') no-repeat center center fixed;
            background-size: cover;
            padding-left:600px;
        }

        .login-container {
            text-align: center;
            color: white;
            padding-bottom:20px;
        }

        .login-container h1 {
            margin-bottom: 10px;
            font-size: 40px;
            color:black;
        }

        .login-container h2 {
            margin-bottom: 20px;
            font-size: 30px;
            font-weight: normal;
            color:black;
        }

        label {
            display: block;
            margin-top: 10px;
            font-size: 14px;
            font-weight: bold;
            border-radius:12px;
            color: #fff;
            text-align: left;
        }

        .input-box {
            width: 280px;
            padding: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
            font-size: 14px;
            border-radius: 12px;
        }

        .input-box.error-border {
            border-color: red;
        }

        .password-container {
            position: relative;
        }

        .toggle-pass {
            position: absolute;
            right: 10px;
            top: 50%;
            font-size: 12px;
            background: none;
            border: none;
            cursor: pointer;
            color: black;
        }

        .btn-login, .btn-back {
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 12px;
        }

        .btn-login {
            background: #2196F3;
        }

        .btn-login:hover {
            background: #1976D2;
        }

        .btn-back {
            background: #9E9E9E;
        }

        .btn-back:hover {
            background: #757575;
        }

        .forgot-link, .register-link {
            display: block;
            margin-top: 12px;
            font-size: 14px;
            text-align: center;
            text-decoration: none;
        }

        .forgot-link {
            color: #FFD700;
        }

        .register-link {
            color: #00FF7F;
        }

        .forgot-link:hover,
        .register-link:hover {
            text-decoration: underline;
        }

        .error {
            color: black;
            font-size: 12px;
            text-align: left;
            margin-top: 3px;
            display: block;
            min-height: 16px;
        }
    </style>

    <script type="text/javascript">
        function togglePassword() {
            var passField = document.getElementById("<%= passtxt.ClientID %>");
            var btn = document.getElementById("toggleBtn");
            if (passField.type === "password") {
                passField.type = "text";
                btn.innerText = "Hide";
            } else {
                passField.type = "password";
                btn.innerText = "Show";
            }
        }

        function validateUsername() {
            var txt = document.getElementById("<%= usertxt.ClientID %>");
            var errorSpan = document.getElementById("usernameError");
            var regex = /^[a-zA-Z]*$/;
            if (!regex.test(txt.value)) {
                errorSpan.innerText = "Username must contain letters only!";
                txt.classList.add("error-border");
            } else {
                errorSpan.innerText = "";
                txt.classList.remove("error-border");
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h1>ShopSavvy</h1>
            <h2>Login</h2>

            <label for="usertxt">User Name</label>
            <asp:TextBox ID="usertxt" runat="server" CssClass="input-box"></asp:TextBox>
            <span id="usernameError" class="error"></span>

            <label for="passtxt">Password</label>
            <div class="password-container">
                <asp:TextBox ID="passtxt" runat="server" CssClass="input-box" TextMode="Password"></asp:TextBox>
                <button type="button" id="toggleBtn" class="toggle-pass" onclick="togglePassword()">Show</button>
            </div>

            <asp:HyperLink ID="ForgotPasswordLink" runat="server" NavigateUrl="~/forgotpassword.aspx" CssClass="forgot-link">
                Forgot Password?
            </asp:HyperLink>

            <asp:Button ID="Button1" runat="server" CssClass="btn-login" Text="Login" OnClick="Button1_Click" />

            <asp:Label ID="Label3" runat="server" Text="Don't have an account?" ForeColor="White"></asp:Label>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/registerpage.aspx" CssClass="register-link">Register Now</asp:HyperLink>

            <asp:Button ID="btnBack" runat="server" CssClass="btn-back" Text="Back" PostBackUrl="~/StartPage.aspx" />
        </div>
    </form>
</body>
</html>
