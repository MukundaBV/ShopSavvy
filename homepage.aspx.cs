using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Globalization;
using System.Web.UI.WebControls;
using System.Data;

namespace shopsavvy
{
    public partial class homepage : System.Web.UI.Page
    {
        string connStr = @"Data Source=MUKUNDA\SQLEXPRESS;Initial Catalog=shopsavvy;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
                if (Session["Cart"] == null)
                {
                    Session["Cart"] = new List<CartItem>();
                }
                BindCart();
            }
        }

        private void LoadProducts(string search = "")
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT ProductName, Price, Quantity, PhotoUrl FROM Products1";
                if (!string.IsNullOrEmpty(search))
                    query += " WHERE ProductName LIKE @search";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(search))
                        cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            rptProducts.DataSource = dt;
            rptProducts.DataBind();

            pnlNotFound.Visible = (!string.IsNullOrEmpty(search) && dt.Rows.Count == 0);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadProducts(txtSearch.Text.Trim());
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadProducts();
        }

        protected void btnAddToCart_Command(object sender, CommandEventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                RepeaterItem item = (RepeaterItem)btn.NamingContainer;

                string productName = ((HiddenField)item.FindControl("hfProductName")).Value;
                string priceText = ((HiddenField)item.FindControl("hfPrice")).Value;
                string availableText = ((HiddenField)item.FindControl("hfAvailable")).Value;
                string qtyText = ((TextBox)item.FindControl("txtQty")).Text;

                // Declare variables first
                int available = 0;
                int qty = 0;
                decimal price = 0;

                if (!int.TryParse(availableText, out available)) return;
                if (!int.TryParse(qtyText, out qty) || qty <= 0) return;
                if (!decimal.TryParse(priceText, NumberStyles.Any, CultureInfo.InvariantCulture, out price))
                {
                    decimal.TryParse(priceText, out price);
                }
                if (qty > available) return;

                int rowsAffected = 0;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string updateSql = "UPDATE Products1 SET Quantity = Quantity - @qty WHERE ProductName = @name AND Quantity >= @qty";
                    using (SqlCommand cmd = new SqlCommand(updateSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@qty", qty);
                        cmd.Parameters.AddWithValue("@name", productName);
                        rowsAffected = cmd.ExecuteNonQuery();
                    }
                }
                if (rowsAffected == 0) { LoadProducts(); return; }

                List<CartItem> cart = Session["Cart"] as List<CartItem> ?? new List<CartItem>();
                CartItem existing = cart.Find(delegate(CartItem c) { return c.ProductName.Equals(productName, StringComparison.OrdinalIgnoreCase); });

                if (existing != null)
                {
                    existing.Quantity += qty;
                }
                else
                {
                    cart.Add(new CartItem { ProductName = productName, Price = price, Quantity = qty });
                }
                Session["Cart"] = cart;

                BindCart();
                LoadProducts();
            }
            catch { }
        }

        private void BindCart()
        {
            List<CartItem> cart = Session["Cart"] as List<CartItem> ?? new List<CartItem>();
            gvCart.DataSource = cart;
            gvCart.DataBind();
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RemoveFromCart")
            {
                string productName = Convert.ToString(e.CommandArgument);
                List<CartItem> cart = Session["Cart"] as List<CartItem>;
                if (cart == null) return;

                CartItem item = cart.Find(delegate(CartItem c) { return c.ProductName.Equals(productName, StringComparison.OrdinalIgnoreCase); });
                if (item == null) return;

                int restoreQty = item.Quantity;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string sql = "UPDATE Products1 SET Quantity = Quantity + @qty WHERE ProductName = @name";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@qty", restoreQty);
                        cmd.Parameters.AddWithValue("@name", productName);
                        cmd.ExecuteNonQuery();
                    }
                }

                cart.Remove(item);
                Session["Cart"] = cart;

                BindCart();
                LoadProducts();
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            List<CartItem> cart = Session["Cart"] as List<CartItem>;
            if (cart == null || cart.Count == 0)
            {
                lblAck.Text = "Your cart is empty. Please add products before placing an order.";
                pnlAck.Visible = true;
                return;
            }

            decimal total = 0;
            foreach (CartItem item in cart)
            {
                total += item.Price * item.Quantity;
            }

            Session["CartTotal"] = total;
            Session["CartItems"] = cart;
            Session["Discount"] = "200"; // Example static discount

            Response.Redirect("orderdetails.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("loginpage.aspx");
        }
    }

    [Serializable]
    public class CartItem
    {
        public string ProductName { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public decimal Total { get { return Price * Quantity; } }
    }
}
