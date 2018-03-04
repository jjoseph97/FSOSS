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
        // Latest Update March 4, 2018. Ren
        [Key, Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int administrator_account_id { get; set; }
       
        [Key, Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int security_role_id { get; set; }

        [Required]
        public DateTime date_modified { get; set; }

        public virtual AdministratorAccount administratoraccount { get; set; }
        public virtual SecurityRole securityrole { get; set; }
    }
}
