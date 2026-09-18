<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registerpage.aspx.cs" Inherits="shopsavvy.registerpage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ShopSavvy | Register</title>
    <style type="text/css">
        body {
            margin: 0;
            height: 100%; /* changed from 100vh to satisfy CSS2.1 validation */
            display: block; /* fallback instead of flex for validation */
            font-family:'Gill Sans MT';
            font-size:small;
            background: url('images/retouch_2025091822415930.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #ffffff;
            position: relative;
            padding-left: 289px;
        }

        /* Overlay to make content readable */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.4);
            z-index: 0;
        }

        /* Form container */
        .form-container {
            position: relative;
            z-index: 1;
            width: 250px;
            padding: 30px;
            background: none;
            border-radius: 10px;
            padding-bottom:100px;
            font-size:14px;
        }

        h1 {
            margin-bottom: 10px;
            font-size: 40px;
            text-align:center;
            color: whitesmoke;
        }

        label {
            display: block;
            margin-top: 10px;
            font-size: 14px;
            font-weight: bold;
            color: floralwhite;
        }

        .input-box {
            width: 100%;
            padding: 8px;
            border: 2px solid #ccc;
            margin-top: 5px;
            font-size: 14px;
            border-radius: 20px;
        }

        .error-msg {
            color:orangered;
            font-size: 12px;
            margin-top: 2px;
        }

        .password-container {
            position: relative;
        }

        .toggle-pass {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 12px;
            background: none;
            border: none;
            cursor: pointer;
            color:black;
        }

        .btn-register {
            width: 107%;
            padding: 10px;
            margin-top: 15px;
            border: none;
            background: #28a745;
            color: white;
            font-size: 14px;
            cursor: pointer;
            border-radius: 20px;
            align-content:center;
        }

        .btn-register:hover {
            background: #22a038;
        }

        .login-link {
            display: block;
            margin-top: 15px;
            font-size: 14px;
            color: #00bfff;
            text-decoration:dashed;
        }

        .login-link:hover {
            text-decoration:dotted;
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

        // Real-time validation
        window.onload = function () {
            var nameBox = document.getElementById("<%= nametxt.ClientID %>");
            var emailBox = document.getElementById("<%= emailtxt.ClientID %>");
            var nameError = document.getElementById("<%= lblNameError.ClientID %>");
            var emailError = document.getElementById("<%= lblEmailError.ClientID %>");

            // Name validation
            nameBox.addEventListener("input", function () {
                var regex = /^[A-Za-z\s]*$/;
                if (!regex.test(nameBox.value)) {
                    nameError.innerText = "Only characters allowed";
                } else {
                    nameError.innerText = "";
                }
            });

            // Email validation (only Gmail)
            emailBox.addEventListener("input", function () {
                var regex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
                if (emailBox.value.length > 0 && !regex.test(emailBox.value)) {
                    emailError.innerText = "Email must be a valid Gmail address";
                } else {
                    emailError.innerText = "";
                }
            });
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h1>Register Here!!</h1>

            <label for="nametxt">Name</label>
            <asp:TextBox ID="nametxt" runat="server" CssClass="input-box"></asp:TextBox>
            <asp:Label ID="lblNameError" runat="server" CssClass="error-msg"></asp:Label>

            <label for="emailtxt">Email ID</label>
            <asp:TextBox ID="emailtxt" runat="server" CssClass="input-box"></asp:TextBox>
            <asp:Label ID="lblEmailError" runat="server" CssClass="error-msg"></asp:Label>

            <label for="passtxt">Password</label>
            <div class="password-container">
                <asp:TextBox ID="passtxt" runat="server" CssClass="input-box" TextMode="Password"></asp:TextBox>
                <button type="button" id="toggleBtn" class="toggle-pass" onclick="togglePassword()">Show</button>
            </div>

            <asp:Button ID="Button1" runat="server" Text="Register" CssClass="btn-register" OnClick="Button1_Click" />

            <asp:Label ID="Label6" runat="server" EnableViewState="False"></asp:Label>

            <asp:Label ID="Label5" runat="server" Text="Already have an account?"></asp:Label>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/loginpage.aspx" CssClass="login-link">Login here</asp:HyperLink>
        </div>
    </form>
</body>
</html>
