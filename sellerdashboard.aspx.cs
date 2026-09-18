using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace ShopSavvy.Web
{
    public partial class sellerdashboard : System.Web.UI.Page
    {
        string connStr = @"Data Source=MUKUNDA\SQLEXPRESS;Initial Catalog=shopsavvy;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckLowStock(); // Low stock check
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string priceText = txtPrice.Text.Trim();
            string qtyText = txtQuantity.Text.Trim();
            string photoUrl = "";

            decimal price = 0;
            int quantity = 0;

            if (string.IsNullOrWhiteSpace(name) ||
                !decimal.TryParse(priceText, out price) ||
                !int.TryParse(qtyText, out quantity))
            {
                lblMessage.Text = "Please enter valid product details.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (filePhoto.HasFile)
            {
                try
                {
                    string folderPath = Server.MapPath("~/ProductImages/");
                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string fileName = Path.GetFileName(filePhoto.FileName);
                    string filePath = Path.Combine(folderPath, fileName);

                    filePhoto.SaveAs(filePath);
                    photoUrl = "ProductImages/" + fileName;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Image upload failed: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    string checkQuery = "SELECT Quantity, PhotoUrl FROM Products1 WHERE ProductName = @name";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@name", name);
                        using (SqlDataReader reader = checkCmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int oldQuantity = Convert.ToInt32(reader["Quantity"]);
                                string oldPhotoUrl = reader["PhotoUrl"].ToString();
                                int newQuantity = oldQuantity + quantity;

                                reader.Close();

                                if (string.IsNullOrEmpty(photoUrl))
                                    photoUrl = oldPhotoUrl;

                                string updateQuery = "UPDATE Products1 SET Quantity = @newQty, Price = @price, PhotoUrl = @photo WHERE ProductName = @name";
                                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@newQty", newQuantity);
                                    updateCmd.Parameters.AddWithValue("@price", price);
                                    updateCmd.Parameters.AddWithValue("@photo", photoUrl);
                                    updateCmd.Parameters.AddWithValue("@name", name);
                                    updateCmd.ExecuteNonQuery();
                                }

                                lblMessage.Text = "Product already exists. Quantity updated!";
                                lblMessage.ForeColor = System.Drawing.Color.Green;
                            }
                            else
                            {
                                reader.Close();

                                string insertQuery = "INSERT INTO Products1 (ProductName, Price, Quantity, PhotoUrl) VALUES (@name, @price, @qty, @photo)";
                                using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                                {
                                    insertCmd.Parameters.AddWithValue("@name", name);
                                    insertCmd.Parameters.AddWithValue("@price", price);
                                    insertCmd.Parameters.AddWithValue("@qty", quantity);
                                    insertCmd.Parameters.AddWithValue("@photo", photoUrl);
                                    insertCmd.ExecuteNonQuery();
                                }

                                lblMessage.Text = "New product added successfully!";
                                lblMessage.ForeColor = System.Drawing.Color.Green;
                            }
                        }
                    }
                }

                // Clear fields
                txtName.Text = "";
                txtPrice.Text = "";
                txtQuantity.Text = "";

                rptInventory.DataBind();
                CheckLowStock();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error saving product: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void rptInventory_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                string productName = e.CommandArgument.ToString();

                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();
                        string deleteQuery = "DELETE FROM Products1 WHERE ProductName = @name";
                        using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@name", productName);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    lblMessage.Text = "Product deleted successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    rptInventory.DataBind();
                    CheckLowStock();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error deleting product: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void ddlHome_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selected = ddlHome.SelectedValue;
            string panel = "";

            if (selected == "account")
                panel = "pnlAccount";
            else if (selected == "faq")
                panel = "pnlFAQ";

            string script = string.Format("togglePanel('{0}');", panel);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showPanel", script, true);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("sellerlogin.aspx");
        }

        private void CheckLowStock()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = "SELECT ProductName, Quantity FROM Products1 WHERE Quantity < 5";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            var lowStockList = new System.Collections.Generic.List<string>();
                            while (reader.Read())
                            {
                                lowStockList.Add(reader["ProductName"].ToString());
                            }

                            if (lowStockList.Count > 0)
                            {
                                lblMessage.Text = "⚠ Low Stock Alert: " + string.Join(", ", lowStockList) + ". Please restock soon!";
                                lblMessage.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                lblMessage.Text = "";
                            }
                        }
                    }
                }
            }
            catch
            {
                // silently fail
            }
        }
    }
}
