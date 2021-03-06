﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class MealPOCO
    {
        public int mealID { get; set; }
        public string mealName { get; set; }
        public DateTime dateModified { get; set; }
        public int administratorAccountId { get; set; }
        public string username { get; set; }
        public bool archivedYn { get; set; }
    }
}
