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
    [Table("gender", Schema = "public")]
    public class Gender
    {

        // Latest Update March 4, 2018. Ren
        [Key]
        public int gender_id { get; set; }
        [Required(ErrorMessage = "Gender description required")]
        [StringLength(100, ErrorMessage = "Enter gender description cannot exceed 100 character")]
        public String gender_description { get; set; }

        public virtual ICollection<SubmittedSurvey> submittedsurvey { get; set; }
    }
}
