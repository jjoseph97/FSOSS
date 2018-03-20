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
    [Table("survey_word", Schema = "public")]
    public class SurveyWord
    {
        // Latest Update March 4, 2018. Ren
        [Key, Column("survey_word_id",Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int survey_word_id { get; set; }
        [Key, Column("site_id",Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int site_id { get; set; }

        [Required (ErrorMessage = "Date used required")]
        public DateTime date_used { get; set; }


        public virtual PotentialSurveyWord PotentialSurveyWord { get; set; }
        public virtual Site Site { get; set; }
    }
}
