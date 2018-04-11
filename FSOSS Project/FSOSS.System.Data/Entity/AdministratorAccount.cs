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
    [Table("administrator_account", Schema = "public")]
    public class AdministratorAccount
    {
        // Latest Update March 4, 2018. Ren //updated march 20, 2018. Chris: Demographic CRUD

        [Key]
        public int administrator_account_id { get; set; }
        [Required, StringLength(100, ErrorMessage = "Username can only be 100 characters long")]
        public string username { get; set; }
        [Required, StringLength(60, ErrorMessage = "Password can only be 60 characters long")]
        public string admin_password { get; set; }
        [Required, StringLength(50, ErrorMessage = "First Name can only be 50 characters long")]
        public string first_name { get; set; }
        [Required, StringLength(50, ErrorMessage = "Last Name can only be 50 characters long")]
        public string last_name { get; set; }
        [Required]
        public bool archived_yn {get; set;}
        [Required]
        public DateTime date_created { get; set; }
        [Required]
        public DateTime date_modified { get; set; }

        public virtual ICollection<AdministratorRole> administratorrole { get; set; }
        public virtual ICollection<Question> questions { get; set; }
        public virtual ICollection<Unit> units { get; set; }
        public virtual ICollection<Site> sites { get; set; }
        public virtual ICollection<Meal> meals { get; set; }
        public virtual ICollection<Gender> genders { get; set; }
        public virtual ICollection<ParticipantType> participant_types { get; set; }
        public virtual ICollection<AgeRange> age_ranges { get; set; }
    }
}
