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
        // Latest Update March 4, 2018. Ren
        [Key]
        public int question_id { get; set; }
         
        [ForeignKey("AdministratorAccount")]
        public int administrator_account_id { get; set;}

        [ForeignKey("QuestionFormat")]
        public int question_format_id { get; set; }

        [ForeignKey("QuestionTopic")]
        public int question_topic_id { get; set; }

        [Required (ErrorMessage ="Question text required")]
        [StringLength(250, ErrorMessage ="Question text cannot exceed 250 characters")]
        public string question_text { get; set; }
        [Required]
        public DateTime date_created { get; set; }
        [Required]
        public bool is_extra { get; set; }

        public virtual ICollection<QuestionSelection> questionselections { get; set; }
        public virtual AdministratorAccount AdministratorAccount { get; set; }
        public virtual QuestionFormat QuestionFormat { get; set; }
        public virtual QuestionTopic QuestionTopic { get; set; }
        public virtual ICollection<ParticipantResponse> participantresponse { get; set; }
        public virtual ICollection<SurveyQuestion> surveyquestion { get; set; }
    }
}
