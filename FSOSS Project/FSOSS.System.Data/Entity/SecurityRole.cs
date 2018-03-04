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
    [Table("security_role", Schema = "public")]
    public class SecurityRole
    {
        [Key]
        public int security__role__id { get; set; }
        public string security_description { get; set; }
    }
}
