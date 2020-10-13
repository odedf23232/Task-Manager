using MyWebApp1.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyWebApp1
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Submit_Login(object sender, EventArgs e)
        {
            using (MyDataClassesDataContext dbContext = new MyDataClassesDataContext())
            {
                List<User> logged_user = dbContext.Users.Where(Users => Users.Email == Email.Text && Users.Password == Password.Text).ToList();
                if (logged_user.Any())
                {
                    //Right login input
                    Session["UserData"] = logged_user[0].FirstName + " " + logged_user[0].LastName; 
                    Session["NewUserName"] = Email.Text;
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    //Wrong login input
                    CheckText.Text = "Wrong login input, please try again.";
                    TestPanel.Visible = true;
                }
            }
        }

        protected void Create_User(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}