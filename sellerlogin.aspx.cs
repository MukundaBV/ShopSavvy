using System;

namespace shopsavvy
{
    public partial class sellerlogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // ✅ Hardcoded seller login
            if (username == "admin" && password == "admin1100")
            {
                Response.Redirect("sellerdashboard.aspx");
            }
            else
            {
                Response.Write("<script>alert('Invalid Username or Password');</script>");
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("startpage.aspx");
        }

    }
}