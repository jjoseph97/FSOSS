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
        // Latest Update March 4, 2018. Ren
        [Key]
        public int question_topic_id { get; set; }

        [Required(ErrorMessage = "Question topic description required")]
        [StringLength(100, ErrorMessage ="Question topic cannot exceed 100 characters")]
        public string question_topic_description { get; set; }

        public virtual ICollection<Question> question { get; set; }
    }
}
