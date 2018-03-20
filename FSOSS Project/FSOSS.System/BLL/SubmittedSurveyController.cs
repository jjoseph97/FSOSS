using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using FSOSS.System.Data.DTO;

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
                    var contactCount = context.SubmittedSurveys.Count(x => x.contact_request == true && x.contacted==false);
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
                                        x.contact_request == true &&
                                        x.contacted==false
                                      select new ContactSubmittedSurveyPOCO
                                      {
                                          submittedSurveyID = x.submitted_survey_id,
                                          unitNumber = x.Unit.unit_number,
                                          participantType = x.ParticipantType.participant_description,
                                          dateEntered = x.date_entered,
                                          contactRequest = x.contact_request,
                                          contacted=x.contacted,
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
        public List<SubmittedSurveyPOCO> GetSubmittedSurveyList(int siteID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    var submittedSurveyList = from x in context.SubmittedSurveys
                                              orderby x.date_entered
                                             // where x.site_id == siteID
                                             select new SubmittedSurveyPOCO()
                                             {
                                                 submittedSurveyID = x.submitted_survey_id,
                                                 unitNumber = x.Unit.unit_number,
                                                 mealName = x.Meal.meal_name,
                                                 participantType = x.ParticipantType.participant_description,
                                                 ageRange = x.AgeRange.age_range_description,
                                                 gender = x.Gender.gender_description,
                                                 dateEntered = x.date_entered,
                                                 contactRequest = x.contact_request,
                                                 contacted=x.contacted,
                                                 contactRoomNumber = x.contact_room_number,
                                                 contactPhoneNumber = x.contact_phone_number
                                             };

                    return submittedSurveyList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }




        }

        //obtain specific submitted survey results
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public SubmittedSurveyPOCO GetSubmittedSurvey(int subSurNum)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var survey = from x in context.SubmittedSurveys
                                 where x.submitted_survey_id == subSurNum
                                 select new SubmittedSurveyPOCO
                                 {
                                     submittedSurveyID = x.submitted_survey_id,
                                     unitNumber = x.Unit.unit_number,
                                     mealName = x.Meal.meal_name,
                                     participantType = x.ParticipantType.participant_description,
                                     ageRange = x.AgeRange.age_range_description,
                                     gender = x.Gender.gender_description,
                                     dateEntered = x.date_entered,
                                     contactRequest = x.contact_request,
                                     contacted=x.contacted,
                                     contactRoomNumber = x.contact_room_number,
                                     contactPhoneNumber = x.contact_phone_number
                                     
                                 };
                    return (SubmittedSurveyPOCO)survey.FirstOrDefault();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

        }

        //obtain specific submitted survey answers
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ParticipantResponsePOCO> GetSubmittedSurveyAnswers(int subSurNum)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var survey = (from y in context.ParticipantResponses
                                                where y.submitted_survey_id == subSurNum
                                                select new ParticipantResponsePOCO
                                                {
                                                    question = y.question.question_text,
                                                    response = y.participant_answer
                                                }).Take(9);
                    return survey.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

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
                    SubmittedSurvey ss = context.SubmittedSurveys.Find(submittedSurveyID);
                    ss.contacted = true;

                    context.Entry(ss).Property(y => y.contacted).IsModified = true;
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

