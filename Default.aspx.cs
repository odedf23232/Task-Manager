using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace MyWebApp1
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["NewUserName"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            LabelUserName.Text = "Welcome " + Session["UserData"].ToString();
        }

        protected void Logout(object sender, EventArgs e)
        {
            Session["NewUserName"] = null;
            Response.Redirect("Login.aspx");
        }
    }
}