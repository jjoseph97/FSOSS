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
        // Latest Update March 4, 2018. Ren
        [Key]
        public int question_format_id { get; set; }
        [Required (ErrorMessage = "Question format required")]
        [StringLength(100, ErrorMessage ="Question format name cannot exceed 100 characters")]
        public string question_format_name { get; set; }

        public virtual ICollection<Question> question { get; set; }
    }
}
