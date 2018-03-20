using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class ParticipantTypePOCO
    {
        public int participantTypeID { get; set; }
        public string participantTypeDescription { get; set; }
        public DateTime dateModified { get; set; }
        public int administratorAccountId { get; set; }
        public bool archivedYn { get; set; }
    }
}
