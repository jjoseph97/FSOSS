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
    //created feb 28-c
    [Table("question_format", Schema ="public")]
    public class QuestionFormat
    {
        [Key]
        public int format_id { get; set; }
        public string format_name { get; set; }
    }
}
