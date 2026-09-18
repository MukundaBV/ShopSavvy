using System;

namespace shopsavvy
{
    public partial class startpage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("registerpage.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("loginpage.aspx");
        }

        protected void btnSellerLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("sellerlogin.aspx");
        }
    }
}