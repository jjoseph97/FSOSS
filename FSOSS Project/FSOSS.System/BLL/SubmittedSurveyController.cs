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

        /// </summary>
        /// <param name="siteID">the id of the site for which we want to know the number of contact requests</param>
        /// <returns></returns>
        public int GetContactRequestTotal(int siteID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var contactCount = context.SubmittedSurveys.Count(x => x.contact_request == true && x.contacted == false && x.Unit.site_id == siteID);
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
                                          mealName = x.Meal.meal_name,
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
                                                  orderby x.date_entered
                                                  where x.date_entered >= startDate && x.date_entered <= endDate && x.meal_id == mealID
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
                                                      contacted = x.contacted,
                                                      contactRoomNumber = x.contact_room_number,
                                                      contactPhoneNumber = x.contact_phone_number
                                                  };
                        return submittedSurveyList.ToList();
                    }
                    else if (siteID != 0 && mealID != 0)
                    {
                        var submittedSurveyList = from x in context.SubmittedSurveys
                                                  orderby x.date_entered
                                                  where x.Unit.site_id == siteID && x.date_entered >= startDate && x.date_entered <= endDate && x.meal_id == mealID
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
                                                      contacted = x.contacted,
                                                      contactRoomNumber = x.contact_room_number,
                                                      contactPhoneNumber = x.contact_phone_number
                                                  };
                        return submittedSurveyList.ToList();
                    }
                    else if (mealID == 0 && unitID != 0)
                    {
                        var submittedSurveyList = from x in context.SubmittedSurveys
                                                  orderby x.date_entered
                                                  where x.date_entered >= startDate && x.date_entered <= endDate && x.unit_id == unitID
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
                                                      contacted = x.contacted,
                                                      contactRoomNumber = x.contact_room_number,
                                                      contactPhoneNumber = x.contact_phone_number
                                                  };
                        return submittedSurveyList.ToList();
                    }
                    else
                    {
                        var submittedSurveyList = from x in context.SubmittedSurveys
                                                  orderby x.date_entered
                                                  where x.date_entered >= startDate && x.date_entered <= endDate
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
        /// <param name="subSurNum"></param>
        /// <returns></returns>
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
                                     site = x.Unit.Site.site_name,
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

        /// <summary>
        /// This method obtains specific submitted survey answers
        /// </summary>
        /// <param name="subSurNum"></param>
        /// <returns></returns>
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



            

        }
        
        /// <summary>
        /// Returns if the participant of the submitted survey 
        /// wants/wanted contact
        /// </summary>
        /// <param name="submittedSurveyID">the submitted survey id of the survey 
        /// which we want to know if they want contact</param>
        /// <returns>true, wants contact. false, no contact wanted/needed</returns>
        public bool wantsContact(int submittedSurveyID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    SubmittedSurvey ss = context.SubmittedSurveys.Find(submittedSurveyID);
                    if (ss.contacted==false && ss.contact_request==true)
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
            using (var connection = new NpgsqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                connection.Open();
                var cmd = new NpgsqlCommand("submit_survey", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("survey_version_id_param", survey_version_id_param);
                cmd.Parameters.AddWithValue("unit_id_param", unit_id_param);
                cmd.Parameters.AddWithValue("meal_id_param", meal_id_param);
                cmd.Parameters.AddWithValue("participant_type_id_param", participant_type_id_param);
                cmd.Parameters.AddWithValue("age_range_id_param", age_range_id_param);
                cmd.Parameters.AddWithValue("gender_id_param", gender_id_param);
                cmd.Parameters.AddWithValue("contact_request_param", contact_request_param);
                cmd.Parameters.AddWithValue("contact_room_number_param", contact_room_number_param);
                cmd.Parameters.AddWithValue("contact_phone_number_param", participant_type_id_param);
                cmd.Parameters.AddWithValue("q1aresponse_param", Q1AResponse_param);
                cmd.Parameters.AddWithValue("q1bresponse_param", Q1BResponse_param);
                cmd.Parameters.AddWithValue("q1cresponse_param", Q1CResponse_param);
                cmd.Parameters.AddWithValue("q1dresponse_param", Q1DResponse_param);
                cmd.Parameters.AddWithValue("q1eresponse_param", Q1EResponse_param);
                cmd.Parameters.AddWithValue("q2response_param", Q2Response_param);
                cmd.Parameters.AddWithValue("q3response_param", Q3Response_param);
                cmd.Parameters.AddWithValue("q4response_param", Q4Response_param);
                cmd.Parameters.AddWithValue("q5response_param", Q5Response_param);
                //cmd.ExecuteReader();
                connection.Close();
            }
        }



    }
}

