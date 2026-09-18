using System;
using System.Data.SqlClient;

namespace shopsavvy
{
    public partial class loginpage : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=MUKUNDA\SQLEXPRESS;Initial Catalog=shopsavvy;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e) { }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string usernameInput = usertxt.Text.Trim();
            string passwordInput = passtxt.Text.Trim();

            if (string.IsNullOrEmpty(usernameInput))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter username');", true);
                return;
            }

            if (string.IsNullOrEmpty(passwordInput))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter password');", true);
                return;
            }

            // Extra check: username must contain letters only
            if (!System.Text.RegularExpressions.Regex.IsMatch(usernameInput, @"^[a-zA-Z]+$"))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Username must contain letters only');", true);
                return;
            }

            string check = "SELECT name FROM register_shop WHERE name=@username AND password=@password";
            SqlCommand com = new SqlCommand(check, con);
            com.Parameters.AddWithValue("@username", usernameInput);
            com.Parameters.AddWithValue("@password", passwordInput);

            try
            {
                con.Open();
                object result = com.ExecuteScalar();
                con.Close();

                if (result != null)
                {
                    Session["Username"] = result.ToString();
                    Session["Email"] = usernameInput;
                    Response.Redirect("homepage.aspx");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid username or password');", true);
                }
            }
            catch (Exception ex)
            {
                // Fixed interpolated string using string.Format
                ClientScript.RegisterStartupScript(this.GetType(), "alert", string.Format("alert('Error: {0}');", ex.Message), true);
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open)
                    con.Close();
            }
        }
    }
}
