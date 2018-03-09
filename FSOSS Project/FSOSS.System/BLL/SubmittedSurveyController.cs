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
                    var contactCount = context.SubmittedSurveys.Count(x => x.contact_status == "contact");
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
                                      where x.Unit.site_id == siteID &&
                                        x.contact_status == "contact"
                                      select new ContactSubmittedSurveyPOCO
                                      {
                                          submittedSurveyID = x.submitted_survey_id,
                                          unitNumber = x.Unit.unit_number,
                                          participantType = x.ParticipantType.participant_description,
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



        [DataObjectMethod(DataObjectMethodType.Select, false)]
        /// <summary>
        /// The method to obtain a list of submitted surveys for a  given site
        /// </summary>
        /// <param name="siteID">The id of the site for which we want to know the list of submitted surveys</param>
        /// <returns></returns>
        public List<ContactSubmittedSurveyPOCO> GetSubmittedSurveyList(int siteID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    List<ContactSubmittedSurveyPOCO> L = new List<ContactSubmittedSurveyPOCO>();
                    return L.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }



            //obtain specific submitted survey results

        }


        [DataObjectMethod(DataObjectMethodType.Update, false)]
        /// <summary>
        /// The method to register a submitted survey as "contacted"
        /// </summary>
        /// <param name="submittedSurveyID">The id of the submitted survey that had a contact request, but won't soon</param>
        /// <returns></returns>
        public void contactSurvey(int submittedSurveyID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    SubmittedSurvey ss= context.SubmittedSurveys.Find(submittedSurveyID);
                    ss.contact_status = "contacted";
                  
                    context.Entry(ss).Property(y => y.contact_status).IsModified = true;
                    context.SaveChanges();

                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }



            //obtain specific submitted survey results

        }


    }
}
