using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class SubmittedSurveyPOCO
    {
        public int submittedSurveyID { get; set; }
        public string site { get; set; }
        public string unitNumber { get; set; }
        public string mealName { get; set; }
        public string participantType { get; set; }
        public string ageRange { get; set; }
        public string gender { get; set; }
        public DateTime dateEntered { get; set; }
        public bool contactRequest { get; set; }
        public bool contacted { get; set; }
        public string contactRoomNumber { get; set; }
        public string contactPhoneNumber { get; set; }

        //public List<ParticipantResponsePOCO> answers { get; set; }

    }
}
