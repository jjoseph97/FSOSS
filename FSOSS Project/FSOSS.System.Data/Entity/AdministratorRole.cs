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
    [Table("administrator_role", Schema = "public")]
    public class AdministratorRole
    {
        [Key]
        public int administrator_account__id { get; set; }
        public int security_role_id { get; set; }
        public DateTime date_modified { get; set; }
    }
}
