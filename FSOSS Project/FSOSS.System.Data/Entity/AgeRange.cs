﻿using System;
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
    [Table("age_range", Schema = "public")]
    public class AgeRange
    {

        // Latest Update March 4, 2018. Ren
        [Key]
        public int age_range_id { get; set; }
        [Required(ErrorMessage = "Age range description required")]
        [StringLength(100,ErrorMessage = "Age range description cannot exceed 100 character")]
        public string age_range_description { get; set; }

        public virtual ICollection<SubmittedSurvey> submittedsurvey { get; set; }
    }
}