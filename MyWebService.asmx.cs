using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;

namespace MyWebApp1
{
    /// <summary>
    /// Summary description for MyWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class MyWebService : System.Web.Services.WebService
    {

        [System.Web.Services.WebMethod(EnableSession = true)]
        public void GetUsersTasks()
        {
            List<Task> taskList = new List<Task>();
            string cs = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string user = Session["NewUserName"].ToString();
                SqlCommand cmd = new SqlCommand("Select * From Task Where(Task.UserName ='" + user + "')", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Task user_task = new Task();
                    user_task.TaskName = rdr["TaskName"].ToString();
                    user_task.UserName = rdr["UserName"].ToString();
                    user_task.TaskDescription = rdr["TaskDescription"].ToString();
                    user_task.priority = rdr["priority"].ToString();
                    user_task.Status = rdr["Status"].ToString();
                    taskList.Add(user_task);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(taskList));
        }


        [System.Web.Services.WebMethod(EnableSession = true)]
        public int Insert(string taskname, string taskdescription, string priority)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string user = Session["NewUserName"].ToString();
                string status = "In Progress";
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Task (TaskName, UserName, TaskDescription, priority, Status) VALUES (@TASKName, @USERName, @TASKDescription, @TASKPriority, @TASKStatus)", con))
                {
                    cmd.Parameters.AddWithValue("@TASKName", taskname);
                    cmd.Parameters.AddWithValue("@USERName", user);
                    cmd.Parameters.AddWithValue("@TASKDescription", taskdescription);
                    cmd.Parameters.AddWithValue("@TASKPriority", priority);
                    cmd.Parameters.AddWithValue("@TASKStatus", status);
                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    con.Close();
                    return result;
                }
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public string Delete(string taskname, string taskdescription, string priority)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string user = Session["NewUserName"].ToString();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Task Where(Task.UserName ='" + user + "' AND Task.TaskName = @TASKName AND Task.TaskDescription = @TASKDescription AND Task.priority = @TASKPriority)", con))
                {
                    cmd.Parameters.AddWithValue("@TASKName", taskname);
                    cmd.Parameters.AddWithValue("@TASKDescription", taskdescription);
                    cmd.Parameters.AddWithValue("@TASKPriority", priority);
                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    con.Close();

                    if (result > 0)
                        return "PASS";
                    else
                        return "FAIL";
                }
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public string Update(string taskname, string taskdescription, string priority, string status)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string user = Session["NewUserName"].ToString();
                using (SqlCommand cmd = new SqlCommand("UPDATE Task SET Task.TaskDescription = @TASKDescription, Task.Status = @TASKStatus, Task.priority = @TASKPriority WHERE(Task.UserName = @USERName AND Task.TaskName = @TASKName )", con))
                {
                    cmd.Parameters.AddWithValue("@TASKName", taskname);
                    cmd.Parameters.AddWithValue("@USERName", user);
                    cmd.Parameters.AddWithValue("@TASKDescription", taskdescription);
                    cmd.Parameters.AddWithValue("@TASKPriority", priority);
                    cmd.Parameters.AddWithValue("@TASKStatus", status);
                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    con.Close();

                    if (result > 0)
                        return "PASS";
                    else
                        return "FAIL";
                }
            }
        }
    }
}
