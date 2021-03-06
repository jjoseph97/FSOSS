﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class GenderPOCO
    {
        public int genderID { get; set; }
        public string genderDescription { get; set; }
        public DateTime dateModified { get; set; }
        public string username { get; set; }
        public int administratorAccountId { get; set; }
        public bool archivedYn { get; set; }
    }
}
