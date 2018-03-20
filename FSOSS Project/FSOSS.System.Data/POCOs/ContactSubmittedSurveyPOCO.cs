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
        public string unitNumber { get; set; }
        public string participantType { get; set; }
        public DateTime dateEntered { get; set; }
        public bool contactRequest { get; set; }
        public bool contacted { get; set; }
        public string contactRoomNumber { get; set; }
        public string contactPhoneNumber { get; set; }

    }
}
