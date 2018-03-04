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
        // Latest Update March 4, 2018. Ren

        [Key]
        public int administrator_account_id { get; set; }
        [Required]
        public string username { get; set; }
        [Required]
        public string admin_password { get; set; }
        [Required]
        public string first_name { get; set; }
        [Required]
        public string last_name { get; set; }
        [Required]
        public bool active_yn {get; set;}
        [Required]
        public DateTime date_created { get; set; }
        [Required]
        public DateTime date_modified { get; set; }

        public virtual ICollection<AdministratorRole> administratorrole { get; set; }
        public virtual ICollection<Question> question { get; set; }
        public virtual ICollection<Unit> unit { get; set; }
        public virtual ICollection<Site> site { get; set; }
    }
}
