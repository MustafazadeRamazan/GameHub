using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace IMS_Project.Controllers
{
    public class SettingsController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Close()
        {
            Process[] edgeProcesses = Process.GetProcessesByName("msedge");

            foreach (Process edgeProcess in edgeProcesses)
            {
                edgeProcess.Kill();
            }

            return View("Index");
        }
    }
}