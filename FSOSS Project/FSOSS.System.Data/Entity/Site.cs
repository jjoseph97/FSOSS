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
    [Table("site", Schema = "public")]
    public class Site
    {
        // Latest Update March 8 2018-c
        //  Updated March 4, 2018. Ren
        
        [Key]
        public int site_id { get; set; }
        [Required (ErrorMessage ="Site name required")]
        [StringLength(100, ErrorMessage ="Site name cannot exceed 100 characters")]
        public string site_name { get; set; }
        [Required (ErrorMessage = "Date modified required")]
        public DateTime date_modified { get; set; }
        [ForeignKey("AdministratorAccount")]
        public int administrator_account_id { get; set; }
        public bool archived_yn { get; set; }

        public virtual AdministratorAccount AdministratorAccount { get; set; }
        public virtual ICollection<SurveyWord> surveyword { get; set; }
        public virtual ICollection <Unit> unit { get; set; }
    }
}
