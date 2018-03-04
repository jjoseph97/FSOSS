using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql;
using FSOSS.System;
using System.Data;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FSOSS.System.Data.Entity
{
    [Table("administrator_account", Schema = "public")]
    public class AdministratorAccount
    {
        [Key]
        public string username { get; set; }
        public string admin_password { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public bool active_yn {get; set;}
        public DateTime date_created { get; set; }
        public DateTime date_modified { get; set; }
    }
}
