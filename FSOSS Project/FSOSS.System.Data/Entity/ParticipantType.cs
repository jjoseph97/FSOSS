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
    [Table("participant_type", Schema = "public")]
    public class ParticipantType
    {
        [Key]
        public int participant_type_id { get; set; }
        [Required(ErrorMessage = "Participant description required")]
        [StringLength(100, ErrorMessage = "Participant description cannot exceed 100 character")]
        public string participant_description { get; set; }

        public virtual ICollection<SubmittedSurvey> submittedsurvey { get; set; }
    }
}
