﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class UnitsPOCO
    { 
        
        public int unitID { get; set; }
        public string unitNumber { get; set; }
        public DateTime dateModified { get; set; }
        public int administratorAccountId { get; set; }
        public bool isClosedyn { get; set; }


    }
}
