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
    [Table("question_selection", Schema ="public")]
    public class QuestionSelection
    {
        [Key]
        public int qselection_id { get; set; }
        public int question_id { get; set; }
        public virtual Question question { get; set; }
        public string qselection_text { get; set; }
        public string qselection_value { get; set; }
    }
}