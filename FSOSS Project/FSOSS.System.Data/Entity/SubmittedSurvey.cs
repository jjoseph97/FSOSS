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
        // Latest Update March 4, 2018. Ren
        [Key]
        public int submitted_survey_id { get; set; }
        [ForeignKey("SurveyVersion")]
        public int survey_version_id { get; set; }
        [ForeignKey("Unit")]
        public int unit_id { get; set; }
        [ForeignKey("Meal")]
        public int meal_id { get; set; }
        [ForeignKey("ParticipantType")]
        public int participant_type_id { get; set; }
        [ForeignKey("AgeRange")]
        public int? age_range_id { get; set; }
        [ForeignKey("Gender")]
        public int? gender_id { get; set; }
        [Required (ErrorMessage = "Date entered required")]
        public DateTime date_entered { get; set; }
        
        [Required (ErrorMessage ="Contact Request is required")]
        public bool contact_request { get; set; }
        public bool contacted { get; set; }
        [StringLength(50, ErrorMessage = "Room number cannot exceed 50 characters")]
        public string contact_room_number { get; set; }
        [StringLength(20, ErrorMessage = "Phone number cannot exceed 20 characters")]
        public string contact_phone_number { get; set; }

        public virtual ICollection<ParticipantResponse> participant_responses { get; set; }
        public virtual Unit Unit { get; set; }
        public virtual Meal Meal { get; set; }
        public virtual ParticipantType ParticipantType { get; set; }
        public virtual AgeRange AgeRange { get; set; }
        public virtual Gender Gender { get; set; }
        public virtual SurveyVersion SurveyVersion { get; set; }
    }
}
