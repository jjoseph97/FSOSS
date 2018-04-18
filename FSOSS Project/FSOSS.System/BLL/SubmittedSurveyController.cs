using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using Npgsql;
using System.Configuration;
using System.Data;

//created March 8, 2018-c
namespace FSOSS.System.BLL
{
    [DataObject]
    public class SubmittedSurveyController
    {

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        /// <summary>
        /// The method to obtain the total of contact requests for a given site.
        /// Updated March 22, 2018. Fixed so it returns the count for the site only.- Chris
        /// Updated April 8, 2018. Fixed to handle bad SiteIDs.

        /// </summary>
        /// <param name="siteID">the id of the site for which we want to know the number of contact requests</param>
        /// <returns></returns>
        public int GetContactRequestTotal(int siteID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var contactCount = 0;
                    if (context.Sites.Find(siteID) != null)
                    {
                        contactCount = context.SubmittedSurveys.Count(x => x.contact_request == true && x.contacted == false && x.Unit.site_id == siteID);

                    }
                    return contactCount;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        /// <summary>
        /// Used to check if the given submitted survey ID is a valid submitted survey ID in the database
        /// </summary>
        /// <param name="subSurveyID"></param>
        /// <returns></returns>
        public bool ValidSurvey(int subSurveyID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    bool valid = true;
                    if (context.SubmittedSurveys.Find(subSurveyID) == null)
                    {
                        valid = false;

                    }
                    return valid;

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
                                        x.contacted == false
                                      orderby x.date_entered descending
                                      select new ContactSubmittedSurveyPOCO
                                      {
                                          submittedSurveyID = x.submitted_survey_id,
                                          unitNumber = x.Unit.unit_number,
                                          participantType = x.ParticipantType.participant_description,
                                          mealName = x.Meal.meal_name,
                                          dateEntered = x.date_entered,
                                          contactRequest = x.contact_request,
                                          contacted = x.contacted,
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
        /// The method is used to obtain a list of submitted surveys for a given site
        /// </summary>
        /// <param name="siteID">The id of the site for which we want to know the list of submitted surveys</param>
        /// <returns></returns>
        public List<SubmittedSurveyPOCO> GetSubmittedSurveyList(int siteID, DateTime startDate, DateTime endDate, int mealID, int unitID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    if (siteID == 0 && mealID != 0)
                    {
                        var submittedSurveyList = from x in context.SubmittedSurveys
                                                  orderby x.date_entered descending
                                                  where x.date_entered >= startDate && x.date_entered <= endDate && x.meal_id == mealID
                                                  select new SubmittedSurveyPOCO()
                                                  {
                                                      site = x.Unit.Site.site_name,
                                                      submittedSurveyID = x.submitted_survey_id,
                                                      unitNumber = x.Unit.unit_number,
                                                      mealName = x.Meal.meal_name,
                                                      participantType = x.ParticipantType.participant_description,
                                                      ageRange = x.AgeRange.age_range_description,
                                                      gender = x.Gender.gender_description,
                                                      dateEntered = x.date_entered,
                                                      contactRequest = x.contact_request,
                                                      contacted = x.contacted,
                                                      contactRoomNumber = x.contact_room_number,
                                                      contactPhoneNumber = x.contact_phone_number
                                                  };
                        return submittedSurveyList.ToList();
                    }
                    else if (siteID != 0 && mealID != 0 && unitID == 0)
                    {
                        var submittedSurveyList = from x in context.SubmittedSurveys
                                                  orderby x.date_entered descending
                                                  where x.Unit.site_id == siteID && x.date_entered >= startDate && x.date_entered <= endDate && x.meal_id == mealID
                                                  select new SubmittedSurveyPOCO()
                                                  {
                                                      site = x.Unit.Site.site_name,
                                                      submittedSurveyID = x.submitted_survey_id,
                                                      unitNumber = x.Unit.unit_number,
                                                      mealName = x.Meal.meal_name,
                                                      participantType = x.ParticipantType.participant_description,
                                                      ageRange = x.AgeRange.age_range_description,
                                                      gender = x.Gender.gender_description,
                                                      dateEntered = x.date_entered,
                                                      contactRequest = x.contact_request,
                                                      contacted = x.contacted,
                                                      contactRoomNumber = x.contact_room_number,
                                                      contactPhoneNumber = x.contact_phone_number
                                                  };
                        return submittedSurveyList.ToList();
                    }
                    else if (mealID == 0 && unitID != 0)
                    {
                        var submittedSurveyList = from x in context.SubmittedSurveys
                                                  orderby x.date_entered descending
                                                  where x.date_entered >= startDate && x.date_entered <= endDate && x.unit_id == unitID
                                                  select new SubmittedSurveyPOCO()
                                                  {
                                                      site = x.Unit.Site.site_name,
                                                      submittedSurveyID = x.submitted_survey_id,
                                                      unitNumber = x.Unit.unit_number,
                                                      mealName = x.Meal.meal_name,
                                                      participantType = x.ParticipantType.participant_description,
                                                      ageRange = x.AgeRange.age_range_description,
                                                      gender = x.Gender.gender_description,
                                                      dateEntered = x.date_entered,
                                                      contactRequest = x.contact_request,
                                                      contacted = x.contacted,
                                                      contactRoomNumber = x.contact_room_number,
                                                      contactPhoneNumber = x.contact_phone_number
                                                  };
                        return submittedSurveyList.ToList();
                    }
                    else
                    {
                        var submittedSurveyList = from x in context.SubmittedSurveys
                                                  orderby x.date_entered descending
                                                  where x.date_entered >= startDate && x.date_entered <= endDate
                                                  select new SubmittedSurveyPOCO()
                                                  {
                                                      site = x.Unit.Site.site_name,
                                                      submittedSurveyID = x.submitted_survey_id,
                                                      unitNumber = x.Unit.unit_number,
                                                      mealName = x.Meal.meal_name,
                                                      participantType = x.ParticipantType.participant_description,
                                                      ageRange = x.AgeRange.age_range_description,
                                                      gender = x.Gender.gender_description,
                                                      dateEntered = x.date_entered,
                                                      contactRequest = x.contact_request,
                                                      contacted = x.contacted,
                                                      contactRoomNumber = x.contact_room_number,
                                                      contactPhoneNumber = x.contact_phone_number
                                                  };
                        return submittedSurveyList.ToList();
                    }
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }




        }

        //
        /// <summary>
        /// This method obtains specific submitted survey results
        /// </summary>
        /// <param name="subSurveyID"></param>
        /// <returns></returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public SubmittedSurveyPOCO GetSubmittedSurvey(int subSurveyID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var survey = from x in context.SubmittedSurveys
                                 where x.submitted_survey_id == subSurveyID
                                 select new SubmittedSurveyPOCO
                                 {
                                     submittedSurveyID = x.submitted_survey_id,
                                     site = x.Unit.Site.site_name,
                                     unitNumber = x.Unit.unit_number,
                                     mealName = x.Meal.meal_name,
                                     participantType = x.ParticipantType.participant_description,
                                     ageRange = x.AgeRange.age_range_description,
                                     gender = x.Gender.gender_description,
                                     dateEntered = x.date_entered,
                                     contactRequest = x.contact_request,
                                     contacted = x.contacted,
                                     contactRoomNumber = x.contact_room_number,
                                     contactPhoneNumber = x.contact_phone_number

                                 };
                    return survey.FirstOrDefault();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

        }

        /// <summary>
        /// This method obtains specific submitted survey answers
        /// </summary>
        /// <param name="subSurveyID"></param>
        /// <returns></returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ParticipantResponsePOCO> GetSubmittedSurveyAnswers(int subSurveyID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var survey = (from y in context.ParticipantResponses
                                  where y.submitted_survey_id == subSurveyID
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
        public void ContactSurvey(int submittedSurveyID)
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





        }

        /// <summary>
        /// Returns if the participant of the submitted survey 
        /// wants/wanted contact
        /// </summary>
        /// <param name="submittedSurveyID">the submitted survey id of the survey 
        /// which we want to know if they want contact</param>
        /// <returns>true, wants contact. false, no contact wanted/needed</returns>
        public bool RequestsContact(int submittedSurveyID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    SubmittedSurvey ss = context.SubmittedSurveys.Find(submittedSurveyID);
                    if (ss.contacted == false && ss.contact_request == true)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }

                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        public void SubmitSurvey(int survey_version_id_param, int unit_id_param, int meal_id_param, int participant_type_id_param, int age_range_id_param,
            int gender_id_param, bool contact_request_param, string contact_room_number_param, string contact_phone_number_param, string Q1AResponse_param,
            string Q1BResponse_param, string Q1CResponse_param, string Q1DResponse_param, string Q1EResponse_param, string Q2Response_param, string Q3Response_param,
            string Q4Response_param, string Q5Response_param)
        {
            using (var context = new FSOSSContext())
            {
                SubmittedSurvey newSurvey = new SubmittedSurvey();
                newSurvey.survey_version_id = survey_version_id_param;
                newSurvey.date_entered = DateTime.Now;
                newSurvey.unit_id = unit_id_param;
                newSurvey.meal_id = meal_id_param;
                newSurvey.participant_type_id = participant_type_id_param;
                newSurvey.age_range_id = age_range_id_param;
                newSurvey.gender_id = gender_id_param;
                newSurvey.contact_request = contact_request_param;
                newSurvey.contact_room_number = contact_room_number_param;
                newSurvey.contact_phone_number = contact_phone_number_param;
                context.SubmittedSurveys.Add(newSurvey);
                context.SaveChanges();

                var newSurveyId = (from x in context.SubmittedSurveys
                                   select x.submitted_survey_id).Max();

                ParticipantResponse q1AResponse = new ParticipantResponse();
                q1AResponse.submitted_survey_id = newSurveyId;
                q1AResponse.question_id = 2;
                q1AResponse.participant_answer = Q1AResponse_param;
                context.ParticipantResponses.Add(q1AResponse);
                context.SaveChanges();

                ParticipantResponse q1BResponse = new ParticipantResponse();
                q1BResponse.submitted_survey_id = newSurveyId;
                q1BResponse.question_id = 3;
                q1BResponse.participant_answer = Q1BResponse_param;
                context.ParticipantResponses.Add(q1BResponse);
                context.SaveChanges();

                ParticipantResponse q1CResponse = new ParticipantResponse();
                q1CResponse.submitted_survey_id = newSurveyId;
                q1CResponse.question_id = 4;
                q1CResponse.participant_answer = Q1CResponse_param;
                context.ParticipantResponses.Add(q1CResponse);
                context.SaveChanges();

                ParticipantResponse q1DResponse = new ParticipantResponse();
                q1DResponse.submitted_survey_id = newSurveyId;
                q1DResponse.question_id = 5;
                q1DResponse.participant_answer = Q1DResponse_param;
                context.ParticipantResponses.Add(q1DResponse);
                context.SaveChanges();

                ParticipantResponse q1EResponse = new ParticipantResponse();
                q1EResponse.submitted_survey_id = newSurveyId;
                q1EResponse.question_id = 6;
                q1EResponse.participant_answer = Q1EResponse_param;
                context.ParticipantResponses.Add(q1EResponse);
                context.SaveChanges();

                ParticipantResponse q2Response = new ParticipantResponse();
                q2Response.submitted_survey_id = newSurveyId;
                q2Response.question_id = 8;
                q2Response.participant_answer = Q2Response_param;
                context.ParticipantResponses.Add(q2Response);
                context.SaveChanges();

                ParticipantResponse q3Response = new ParticipantResponse();
                q3Response.submitted_survey_id = newSurveyId;
                q3Response.question_id = 9;
                q3Response.participant_answer = Q3Response_param;
                context.ParticipantResponses.Add(q3Response);
                context.SaveChanges();

                ParticipantResponse q4Response = new ParticipantResponse();
                q4Response.submitted_survey_id = newSurveyId;
                q4Response.question_id = 10;
                q4Response.participant_answer = Q4Response_param;
                context.ParticipantResponses.Add(q4Response);
                context.SaveChanges();

                ParticipantResponse q5Response = new ParticipantResponse();
                q5Response.submitted_survey_id = newSurveyId;
                q5Response.question_id = 11;
                q5Response.participant_answer = Q5Response_param;
                context.ParticipantResponses.Add(q5Response);
                context.SaveChanges();

            }
        }
    }
}

