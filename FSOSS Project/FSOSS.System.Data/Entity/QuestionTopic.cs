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
    [Table("question_topic", Schema ="public")]
    public class QuestionTopic
    {
        [Key]
        public int topic_id { get; set; }
        public string topic_description { get; set; }
    }
}
