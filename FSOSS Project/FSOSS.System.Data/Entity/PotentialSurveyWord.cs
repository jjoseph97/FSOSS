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
    [Table("potential_survey_word", Schema = "public")]
    public class PotentialSurveyWord
    {
        // Latest Update March 4, 2018. Ren
        [Key]
        public int survey_word_id { get; set; }
        [ForeignKey("AdministratorAccount")]
        public int administrator_account_id { get; set; }
        [Required(ErrorMessage = "Survey access word required")]
        [StringLength(8, ErrorMessage = "Survey access word cannot exceed 8 characters")]
        public string survey_access_word { get; set; }
        [Required]
        public DateTime date_modified { get; set; }

        public virtual AdministratorAccount AdministratorAccount { get; set; }
        public virtual ICollection<SurveyWord> surveyword { get; set; }
    }
}
