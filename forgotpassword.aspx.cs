using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace shopsavvy
{
    public partial class forgotpassword : System.Web.UI.Page
    {
        // ✅ Update your SQL Server connection string here
        SqlConnection con = new SqlConnection("Data Source=MUKUNDA\\SQLEXPRESS;Initial Catalog=shopsavvy;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string Email = txtUserOrEmail.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(Email) || string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
            {
                lblMessage.Text = "⚠ Please fill all fields.";
                return;
            }

            if (newPassword != confirmPassword)
            {
                lblMessage.Text = "❌ Passwords do not match!";
                return;
            }

            try
            {
                con.Open();
                // check if username or email exists
                SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM register_shop WHERE email_id=@Email", con);
                checkCmd.Parameters.AddWithValue("@Email", Email);

                int userExists = (int)checkCmd.ExecuteScalar();

                if (userExists > 0)
                {
                    // update password
                    SqlCommand updateCmd = new SqlCommand("UPDATE register_shop SET Password=@Password WHERE email_id=@Email", con);
                    updateCmd.Parameters.AddWithValue("@Password", newPassword);
                    updateCmd.Parameters.AddWithValue("@Email", Email);
                    updateCmd.ExecuteNonQuery();

                    lblMessage.Text = "✅ Password updated successfully! Redirecting to login...";

                    // redirect after 2 sec
                    Response.AddHeader("REFRESH", "2;URL=loginpage.aspx");
                }
                else
                {
                    lblMessage.Text = "❌ No account found with given Email!";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "⚠ Error: " + ex.Message;
            }
            finally
            {
                con.Close();
            }
        }
    }
}