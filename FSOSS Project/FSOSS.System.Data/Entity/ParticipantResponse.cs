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
        [Key]
        //this should reference a submitted survey not a survey version
        public int submitted_survey_id { get; set; }
        [Key]
        public int question_id { get; set; }
        public virtual Question question { get; set; }
        [StringLength(100, ErrorMessage = "Survey response cannot exceed 100 characters")]
        public string participant_answer { get; set; }
        
    }
}