using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Linq;

namespace shopsavvy
{
    public partial class OrderDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Nothing on initial load
        }

        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string address = txtAddress.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string payment = ddlPayment.SelectedItem.Text;

            var cart = Session["Cart"] as List<CartItem>;
            if (cart == null || cart.Count == 0)
            {
                lblAck.Text = "❌ No items in cart. Please go back and add products.";
                pnlAck.Visible = true;
                return;
            }

            decimal total = 0;
            foreach (var item in cart) total += item.Price * item.Quantity;
            decimal discountAmt = (total * 10) / 100; // fixed 10% discount
            decimal finalAmt = total - discountAmt;

            StringBuilder sb = new StringBuilder();
            sb.Append("<h3>🎉 Order Acknowledgment 🎉</h3>");
            sb.Append("<p><b>Name:</b> " + name + "</p>");
            sb.Append("<p><b>Address:</b> " + address + "</p>");
            sb.Append("<p><b>Mobile:</b> " + mobile + "</p>");
            sb.Append("<p><b>Payment Method:</b> " + payment + "</p>");
            sb.Append("<hr/>");
            sb.Append("<h4>🛒 Order Summary:</h4><ul>");

            foreach (var item in cart)
            {
                decimal itemTotal = item.Price * item.Quantity;
                sb.Append("<li>" + item.ProductName + " - " + item.Quantity + " x ₹" +
                          item.Price.ToString("N2") + " = ₹" + itemTotal.ToString("N2") + "</li>");
            }
            sb.Append("</ul>");
            sb.Append("<p><b>Subtotal:</b> ₹" + total.ToString("N2") + "</p>");
            sb.Append("<p><b>Discount (10%):</b> -₹" + discountAmt.ToString("N2") + "</p>");
            sb.Append("<p><b>Total Payable:</b> ₹" + finalAmt.ToString("N2") + "</p>");
            sb.Append("<p style='color:green;font-weight:bold;'>✅ Thank you for shopping with ShopSavvy! </p>");

            lblAck.Text = sb.ToString();
            pnlAck.Visible = true;

            // Clear cart after order confirmation
            Session["Cart"] = new List<CartItem>();
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            Response.Redirect("homepage.aspx");
        }
    }
}