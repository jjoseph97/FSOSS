using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;

//created March 8, 2018-c
namespace FSOSS.System.BLL
{
    [DataObject]
    public class SubmittedSurveyController
    {

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        /// <summary>
        /// The method to obtain the total of contact requests for a given site.
        /// </summary>
        /// <param name="siteID">the id of the site for which we want to know the number of contact requests</param>
        /// <returns></returns>
        public int GetContactRequestTotal(int siteID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var contactCount = context.SubmittedSurveys.Count(x=>x.contact_status=="contact");
                    return contactCount;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }


        [DataObjectMethod(DataObjectMethodType.Select, false)]
        /// <summary>
        /// The method to obtain a list of submitted survey contact requests for a  given site
        /// </summary>
        /// <param name="siteID">The id of the site for which we want to know the list of contact requests</param>
        /// <returns></returns>
        public List<ContactSubmittedSurveyPOCO> GetContactRequestList(int siteID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    var contactList = from x in context.SubmittedSurveys
                                      where x.Unit.site_id == siteID
                                      select new ContactSubmittedSurveyPOCO
                                      {
                                          submittedSurveyID = x.submitted_survey_id,
                                          unitID = x.unit_id,
                                          participantTypeID = x.participant_type_id,
                                          dateEntered = x.date_entered,
                                          contactStatus = x.contact_status,
                                          contactRoomNumber = x.contact_room_number,
                                          contactPhoneNumber = x.contact_phone_number
                                      };
                    return contactList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

        }

        //obtain specific submitted survey results

    }
}
