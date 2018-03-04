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
        [Key]
        public int unit_id { get; set; }
        public int site_id { get; set; }
        public string unit_number { get; set; }
        public DateTime date_modified { get; set; }
        public int administrator_account_id { get; set; }
    }
}
