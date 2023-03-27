namespace GameHub.Models
{

using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public partial class admin_Login
{

    public int LoginID { get; set; }

    public int EmpID { get; set; }

    [Required]
    public string UserName { get; set; }

    [Required]
    public string Password { get; set; }

    public Nullable<int> RoleType { get; set; }

    public string Notes { get; set; }



    public virtual admin_Employee admin_Employee { get; set; }

    public virtual Role Role { get; set; }

}

}
