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
    [Table("survey_question",Schema="public")]
    public class SurveyQuestion
    {
        [Key]
        public int survey_version_id { get; set; }
        public virtual SurveyVersion survey_version { get; set; }
        [Key]
        public int question_id { get; set; }
        public virtual Question question { get; set; }

    }
}
