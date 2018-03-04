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
    [Table("question_format", Schema ="public")]//updated march 3:consistency-c
    public class QuestionFormat
    {
        [Key]
        public int question_format_id { get; set; }
        public string question_format_name { get; set; }
    }
}
