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
    [Table("submitted_survey",Schema="public")]//update march 3: consistency-c
    public class SubmittedSurvey
    {
        [Key]
        public int submitted_survey_id { get; set; }
        public int survey_version_id { get; set; }
        public int unit_id { get; set; }
        public int meal_id { get; set; }
        public int participant_type_id { get; set; }
        public int age_range_id { get; set; }
        public int gender_id { get; set; }
        public DateTime date_entered { get; set; }
        [StringLength(100, ErrorMessage = "Contact status cannot exceed 100 characters")]
        public string contact_status { get; set; }
        [StringLength(50, ErrorMessage = "Room number cannot exceed 50 characters")]
        public string contact_room_number { get; set; }
        [StringLength(20, ErrorMessage = "Phone number cannot exceed 20 characters")]
        public string contact_phone_number { get; set; }

        public virtual ICollection<ParticipantResponse> participant_responses { get; set; }
    }
}
