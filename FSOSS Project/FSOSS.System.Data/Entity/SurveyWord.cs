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
    [Table("survey_word", Schema = "public")]
    public class SurveyWord
    {
        [Key]
        public int survey_word_id { get; set; }
        public int site_id { get; set; }
        public DateTime date_used { get; set; }
    }
}
