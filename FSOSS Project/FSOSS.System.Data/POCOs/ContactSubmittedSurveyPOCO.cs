using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//created March 8, 2018-c
namespace FSOSS.System.Data.POCOs
{
    public class ContactSubmittedSurveyPOCO
    {

        public int submittedSurveyID { get; set; }
        public int unitID { get; set; }
        public int participantTypeID { get; set; }
        public DateTime dateEntered { get; set; }
        public string contactStatus { get; set; }
        public string contactRoomNumber { get; set; }
        public string contactPhoneNumber { get; set; }

    }
}
