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
    
    [Table("question", Schema="public")]//updated march 3: consistency-c
    public class Question
    {
        [Key]
        public int question_id { get; set; }
        
        //created by commented out until administrator account exists-c
        //public int administrator_account_id{get;set;}
        //public virtual Admin{get;set;}

        
        public int question_format_id { get; set; }
        public int question_topic_id { get; set; }
        public string question_text { get; set; }
        public DateTime date_created { get; set; }
        public bool is_extra { get; set; }

        public virtual ICollection<QuestionSelection> question_selections { get; set; }

    }
}
