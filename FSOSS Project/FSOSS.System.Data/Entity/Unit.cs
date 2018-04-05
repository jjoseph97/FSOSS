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
    [Table("unit", Schema = "public")]
    public class Unit
    {
        // Latest Update March 9, 2018-c
        // Updated March 4, 2018. Ren
        [Key]
        public int unit_id { get; set; }

        [ForeignKey("Site")]
        public int site_id { get; set; }
        [Required(ErrorMessage = "Unit number required")]
        [StringLength(100, ErrorMessage = "Unit number cannot exceed 100 characters")]
        public string unit_number { get; set; }
        [Required (ErrorMessage = "Date modified required")]
        public DateTime date_modified { get; set; }
        [ForeignKey("AdministratorAccount")]
        public int administrator_account_id { get; set; }
        public bool archived_yn { get; set; }

        public virtual AdministratorAccount AdministratorAccount { get; set; }
        public virtual Site Site { get; set; }
    }
}
