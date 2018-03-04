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
    [Table("survey_version", Schema ="public")]
    public class SurveyVersion
    {
        // Latest Update March 4, 2018. Ren
        [Key]
        public int version_id { get; set; }
        
        [ForeignKey("AdministratorAccount")]
        public int administrator_account_id{get;set;}
      
        [Required (ErrorMessage = "Stard date required")]
        public DateTime start_date { get; set; }
        public DateTime? end_date { get; set; }

        public virtual AdministratorAccount AdministratorAccount { get; set; }
        public virtual ICollection<SubmittedSurvey> submittedsurvey { get; set; }
        public virtual ICollection<SurveyQuestion> surveyquestion { get; set; }

        /* This is use for fluent API. we "decided" to use DataAnnotation instead so we don't need this. 
         Here's an example of fluent API vs Data Annotation https://stackoverflow.com/questions/5436731/composite-key-as-foreign-key
         - Ren
        */

        //I'm not sure if I did this right, so its commented out for now-c
        //public SurveyVersion()
        //{
        //    SurveyQuestions = new HashSet<SurveyQuestion>();
        //}
        //public virtual ICollection<SurveyQuestion> SurveyQuestions {get;set;}
    }
}
