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
        [Key]
        public int version_id { get; set; }
        
        //'modified_by' commented out until administrator accounts are established and usable-c
        //public int modified_by{get;set;}
        //public virtual AdministratorAccount Admin { get; set; }

        public DateTime start_date { get; set; }
        public DateTime? end_date { get; set; }

        //I'm not sure if I did this right, so its commented out for now-c
        //public SurveyVersion()
        //{
        //    SurveyQuestions = new HashSet<SurveyQuestion>();
        //}
        //public virtual ICollection<SurveyQuestion> SurveyQuestions {get;set;}
    }
}
