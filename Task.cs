using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyWebApp1
{
    public class Task
    {
        public int TaskId { get; set; }
        public string TaskName { get; set; }
        public string UserName { get; set; }
        public string TaskDescription { get; set; }
        public string priority { get; set; }
        public string Status { get; set; }
    }
}