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
        // Latest Update March 4, 2018. Ren
        [Key]
        public int question_selection_id { get; set; }
        [ForeignKey("Question")]
        public int question_id { get; set; }
        [Required (ErrorMessage = "Question selection text required")]
        [StringLength(100, ErrorMessage = "Question selection text required")]
        public string question_selection_text { get; set; }
        [Required(ErrorMessage = "Question selection value required")]
        [StringLength(100, ErrorMessage = "Question selection value required")]
        public string question_selection_value { get; set; }

        public virtual Question Question { get; set; }
    }
}