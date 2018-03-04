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
    [Table("age_range", Schema = "public")]
    public class AgeRange
    {
        [Key]
        public int age_range_id { get; set; }
        public int age_range_description { get; set; }
    }
}
