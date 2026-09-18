using System;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace shopsavvy
{
    public partial class registerpage : System.Web.UI.Page
    {
        // Fixed escape sequence by using @ for verbatim string
        SqlConnection con = new SqlConnection(
            @"Data Source=MUKUNDA\SQLEXPRESS;Initial Catalog=shopsavvy;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblNameError.Text = "";
                lblEmailError.Text = "";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string username = nametxt.Text.Trim();
            string email = emailtxt.Text.Trim();
            string password = passtxt.Text.Trim();

            bool isValid = true;

            // Check for empty fields
            if (string.IsNullOrWhiteSpace(username))
            {
                lblNameError.Text = "Please enter your name";
                isValid = false;
            }

            if (string.IsNullOrWhiteSpace(email))
            {
                lblEmailError.Text = "Please enter your email";
                isValid = false;
            }

            if (!isValid) return;

            // Username validation: only letters and spaces
            if (!Regex.IsMatch(username, @"^[A-Za-z\s]+$"))
            {
                lblNameError.Text = "Name must contain only letters and spaces";
                isValid = false;
            }
            else
            {
                lblNameError.Text = "";
            }

            // Email validation: must be Gmail
            if (!Regex.IsMatch(email, @"^[A-Za-z0-9._%+-]+@gmail\.com$"))
            {
                lblEmailError.Text = "Enter a valid Gmail (example: yourname@gmail.com)";
                isValid = false;
            }
            else
            {
                lblEmailError.Text = "";
            }

            if (!isValid) return;

            try
            {
                con.Open();

                // Check if email already exists
                string checkQuery = "SELECT COUNT(*) FROM register_shop WHERE email_id = @Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@Email", email);

                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    lblEmailError.Text = "Account with this email already exists";
                    return;
                }

                // Insert new user
                string insertQuery = "INSERT INTO register_shop (name, email_id, password) VALUES (@Name, @Email, @Password)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                insertCmd.Parameters.AddWithValue("@Name", username);
                insertCmd.Parameters.AddWithValue("@Email", email);
                insertCmd.Parameters.AddWithValue("@Password", password);

                insertCmd.ExecuteNonQuery();

                Response.Redirect("loginpage.aspx");
            }
            catch (Exception ex)
            {
                Label6.Text = "Error: " + ex.Message;
            }
            finally
            {
                con.Close();
            }
        }
    }
}
