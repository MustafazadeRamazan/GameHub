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
        // GET: Settings
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Close()
        {
            // Get all Microsoft Edge processes
            Process[] edgeProcesses = Process.GetProcessesByName("msedge");

            // Kill all Microsoft Edge processes
            foreach (Process edgeProcess in edgeProcesses)
            {
                edgeProcess.Kill();
            }

            return View("Index");
        }
    }
}