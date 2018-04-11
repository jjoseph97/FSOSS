using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class AgeRangePOCO
    {
        public int ageRangeID { get; set; }
        public string ageRangeDescription { get; set; }
        public DateTime dateModified { get; set; }
        public int administratorAccountId { get; set; }
        public string username { get; set; }
        public bool archivedYn { get; set; }
    }
}
