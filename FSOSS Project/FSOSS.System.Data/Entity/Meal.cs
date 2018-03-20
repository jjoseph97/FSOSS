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
    [Table("meal", Schema = "public")]
    public class Meal
    {

        // Latest Update March 4, 2018. Ren //updated March 20, Chris: CRUD Monitoring
        [Key]
        public int meal_id { get; set; }
        [Required(ErrorMessage = "Meal name required")]
        [StringLength(100, ErrorMessage = "Meal name cannot exceed 100 character")]
        public string meal_name { get; set; }
        [Required(ErrorMessage = "Date modified required")]
        public DateTime date_modified { get; set; }
        [ForeignKey("AdministratorAccount")]
        public int administrator_account_id { get; set; }
        public bool archived_yn { get; set; }

        public virtual AdministratorAccount AdministratorAccount { get; set; }
        public virtual ICollection<SubmittedSurvey> submittedsurvey { get; set; }
    }
}
