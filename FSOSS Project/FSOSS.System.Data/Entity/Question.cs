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
    
    [Table("question", Schema="public")]
    public class Question
    {
        [Key]
        public int question_id { get; set; }
        
        //created by commented out until administrator account exists-c
        //public int created_by{get;set;}
        //public virtual Admin{get;set;}

        
        public int format_id { get; set; }
        public int topic_id { get; set; }
        public string question_text { get; set; }
        public DateTime date_created { get; set; }
        public bool is_extra { get; set; }

        public virtual ICollection<QuestionSelection> question_selections { get; set; }

    }
}
