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
    [Table("participant_response", Schema="public")]
    public class ParticipantResponse
    {
        
        [Key, Column("submitted_survey_id", Order =1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int submitted_survey_id { get; set; }

       
        [Key, Column("question_id", Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int question_id { get; set; }

        [StringLength(100, ErrorMessage = "Survey response cannot exceed 100 characters")]
        public string participant_answer { get; set; }

        public virtual Question question { get; set; }
        public virtual SubmittedSurvey submittedsurvey { get; set; }

    }
}