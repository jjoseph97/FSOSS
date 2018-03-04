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
        // Latest Update March 4, 2018. Ren
        [Key]
        public int security_role_id { get; set; }
        [Required(ErrorMessage = "Security description required")]
        [StringLength(100, ErrorMessage ="Security description cannot exceed 100 characters")]
        public string security_description { get; set; }

        public virtual ICollection<AdministratorRole> administratorrole { get; set; }
    }
}
