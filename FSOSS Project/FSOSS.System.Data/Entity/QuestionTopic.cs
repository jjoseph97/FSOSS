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
    [Table("question_topic", Schema ="public")]//updated march 3:consistency-c
    public class QuestionTopic
    {
        [Key]
        public int question_topic_id { get; set; }
        public string question_topic_description { get; set; }
    }
}
