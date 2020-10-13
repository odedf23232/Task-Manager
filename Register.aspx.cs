using MyWebApp1.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyWebApp1
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Create_User_Click(object sender, EventArgs e)
        {
            MyDataClassesDataContext dbContext = new MyDataClassesDataContext();
            using (dbContext)
            {
                if (dbContext.Users.Where(Users => Users.Email == Email.Text).Any())
                {
                    //User exist's
                    CheckText.Text= "Username exist, try to log in.";
                    TestPanel.Visible = true;
                }
                else
                {
                    //Username doesn't exist.
                    User newUser = new User
                    {
                        FirstName = Fname.Text,
                        LastName = Lname.Text,
                        Email = Email.Text,
                        Password = Password.Text
                    };
                    dbContext.Users.InsertOnSubmit(newUser);
                    dbContext.SubmitChanges();

                    Session["UserData"] = Fname.Text + " " + Lname.Text;
                    Session["NewUserName"] = Email.Text;
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void Goto_Login_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}