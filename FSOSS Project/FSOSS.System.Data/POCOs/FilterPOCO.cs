using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class FilterPOCO
    {
        public DateTime startingDate { get; set; }
        public DateTime endDate { get; set; }
        public int siteID { get; set; }
        public int mealID { get; set; }
        public int unitID { get; set; }
    }
}
