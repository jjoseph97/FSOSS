using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
#region
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
#endregion
namespace FSOSS.System.BLL
{
    public class ReportController
    {
        /// <summary>
        /// This method generate FinalReportPOCO use in chart
        /// </summary>
        /// <param name="startDate">Start date of report scope</param>
        /// <param name="endDate">End date of report scope</param>
        /// <param name="siteID">Site Id of the report scope</param>
        /// <param name="mealID">Meal Id of report scope</param>
        /// <returns></returns>
        public FinalReportPOCO GenerateOverAllReport(DateTime startDate, DateTime endDate, int siteID, int mealID)
        {
            // Start of Transaction
            using (var context = new FSOSSContext())
            {
                // Initialize variables
                List<ParticipantResponse> participantResponseList = new List<ParticipantResponse>();
                List<SubmittedSurvey> submittedSurveyList = new List<SubmittedSurvey>();
                // Check to see if the sideId being passes is zero, get all sites if the site id is set to zero
                // Check to see if the mealId being passes is zero, get all meal if the site id is set to zero 
                if (siteID == 0 && mealID != 0)
                {
                    participantResponseList = (from x in context.ParticipantResponses
                                                                         where x.submittedsurvey.date_entered >= startDate
                                                                         && x.submittedsurvey.date_entered <= endDate
                                                                         && x.submittedsurvey.meal_id == mealID
                                                                         select x).ToList();
                    submittedSurveyList = (from x in context.SubmittedSurveys
                                                                 where x.date_entered >= startDate && x.date_entered <= endDate
                                                                 && x.meal_id == mealID
                                                                 select x).ToList();
                }
                else if (siteID == 0 && mealID == 0)
                {
                    participantResponseList = (from x in context.ParticipantResponses
                                                                         where x.submittedsurvey.date_entered >= startDate
                                                                         && x.submittedsurvey.date_entered <= endDate
                                                                         select x).ToList();
                    submittedSurveyList = (from x in context.SubmittedSurveys
                                                                 where x.date_entered >= startDate && x.date_entered <= endDate
                                                                 select x).ToList();
                }
                else if (mealID == 0 && siteID !=0)
                {
                    participantResponseList = (from x in context.ParticipantResponses
                                                                         where x.submittedsurvey.date_entered >= startDate
                                                                         && x.submittedsurvey.date_entered <= endDate
                                                                         && x.submittedsurvey.Unit.site_id == siteID
                                                                         select x).ToList();
                    submittedSurveyList = (from x in context.SubmittedSurveys
                                                                 where x.date_entered >= startDate && x.date_entered <= endDate
                                                                 && x.Unit.site_id == siteID
                                                                 select x).ToList();
                }
                else
                {
                    participantResponseList = (from x in context.ParticipantResponses
                                                                         where x.submittedsurvey.date_entered >= startDate
                                                                         && x.submittedsurvey.date_entered <= endDate
                                                                         && x.submittedsurvey.Unit.site_id == siteID
                                                                         && x.submittedsurvey.meal_id == mealID
                                                                         select x).ToList();
                    submittedSurveyList = (from x in context.SubmittedSurveys
                                                                 where x.date_entered >= startDate && x.date_entered <= endDate
                                                                 && x.Unit.site_id == siteID
                                                                 && x.meal_id == mealID
                                                                 select x).ToList();
                }
                // Get the list of question
                List<Question> questions = (from x in context.Questions
                                            select x).ToList();
                // Set a list of string to store questions
                List<string> Questions = new List<string>();
                // Loop through the loop and retrieve only questions with a response 
                foreach (Question question in questions)
                {
                    if (question.question_id == 2)
                    {
                        Questions.Add(question.question_text);
                    }
                    else if (question.question_id == 3)
                    {
                        Questions.Add(question.question_text);
                    }
                    else if (question.question_id == 4)
                    {
                        Questions.Add(question.question_text);
                    }
                    else if (question.question_id == 5)
                    {
                        Questions.Add(question.question_text);
                    }
                    else if (question.question_id == 6)
                    {
                        Questions.Add(question.question_text);
                    }
                    else if (question.question_id == 8)
                    {
                        Questions.Add(question.question_text);
                    }
                    else if (question.question_id == 9)
                    {
                        Questions.Add(question.question_text);
                    }
                    else if (question.question_id == 10)
                    {
                        Questions.Add(question.question_text);
                    }
                }
               

                // Initialize all variable required for saving the answer and count
                List<string> QuestionTwoValueList = new List<string>();
                List<int> QuestionTwoValueCount = new List<int>();
                List<string> QuestionThreeValueList = new List<string>();
                List<int> QuestionThreeValueCount = new List<int>();
                List<string> QuestionFourValueList = new List<string>();
                List<int> QuestionFourValueCount = new List<int>();
                List<string> QuestionFiveValueList = new List<string>();
                List<int> QuestionFiveValueCount = new List<int>();
                List<string> QuestionSixValueList = new List<string>();
                List<int> QuestionSixValueCount = new List<int>();
                List<string> QuestionEightValueList = new List<string>();
                List<int> QuestionEightValueCount = new List<int>();
                List<string> QuestionNineValueList = new List<string>();
                List<int> QuestionNineValueCount = new List<int>();
                List<string> QuestionTenValueList = new List<string>();
                List<int> QuestionTenValueCount = new List<int>();
                // initialize valueCounter use for counting the answers from the responses
                int valueCounter = 0;
                // initialize index use for getting the value from the list
                int index = 0;
                // Loop through all the responses from the participant response list
                foreach (ParticipantResponse responses in participantResponseList)
                {
                    // Check to see if the response being check is any of the question with answers                  
                    if (responses.question_id == 2)
                    {
                        // Check if the answer value contains any answer or the answer is not currently in the list.
                        // if there are no answer assign the answer and add a +1 on the list
                        if (QuestionTwoValueList.Count < 1 || !QuestionTwoValueList.Contains(responses.participant_answer))
                        {
                            QuestionTwoValueList.Add(responses.participant_answer);
                            valueCounter++;
                            QuestionTwoValueCount.Add(valueCounter);
                        }
                        // If there is an existing answer on the list
                        else
                        {
                            // Find the index of the existing value
                            index = QuestionTwoValueList.IndexOf(responses.participant_answer);
                            // Get the count associated with the existing value
                            valueCounter = QuestionTwoValueCount[index];
                            // Add a +1 to the value counter
                            valueCounter++;
                            // replace the old value from the list with the new value from the valueCounter
                            QuestionTwoValueCount[index] = valueCounter;
                        }
                        // set the value counter to zero
                        valueCounter = 0;

                    }
                    // Same steps with question_id 2
                    else if (responses.question_id == 3)
                    {
                        if (QuestionThreeValueList.Count < 1 || !QuestionThreeValueList.Contains(responses.participant_answer))
                        {
                            QuestionThreeValueList.Add(responses.participant_answer);
                            valueCounter++;
                            QuestionThreeValueCount.Add(valueCounter);
                        }
                        else
                        {
                            index = QuestionThreeValueList.IndexOf(responses.participant_answer);
                            valueCounter = QuestionThreeValueCount[index];
                            valueCounter++;
                            QuestionThreeValueCount[index] = valueCounter;
                        }
                        valueCounter = 0;
                    }
                    // Same steps with question_id 2
                    else if (responses.question_id == 4)
                    {
                        if (QuestionFourValueList.Count < 1 || !QuestionFourValueList.Contains(responses.participant_answer))
                        {
                            QuestionFourValueList.Add(responses.participant_answer);
                            valueCounter++;
                            QuestionFourValueCount.Add(valueCounter);
                        }
                        else
                        {
                            index = QuestionFourValueList.IndexOf(responses.participant_answer);
                            valueCounter = QuestionFourValueCount[index];
                            valueCounter++;
                            QuestionFourValueCount[index] = valueCounter;
                        }
                        valueCounter = 0;
                    }
                    // Same steps with question_id 2
                    else if (responses.question_id == 5)
                    {
                        if (QuestionFiveValueList.Count < 1 || !QuestionFiveValueList.Contains(responses.participant_answer))
                        {
                            QuestionFiveValueList.Add(responses.participant_answer);
                            valueCounter++;
                            QuestionFiveValueCount.Add(valueCounter);
                        }
                        else
                        {
                            index = QuestionFiveValueList.IndexOf(responses.participant_answer);
                            valueCounter = QuestionFiveValueCount[index];
                            valueCounter++;
                            QuestionFiveValueCount[index] = valueCounter;
                        }
                        valueCounter = 0;
                    }
                    // Same steps with question_id 2
                    else if (responses.question_id == 6)
                    {
                        if (QuestionSixValueList.Count < 1 || !QuestionSixValueList.Contains(responses.participant_answer))
                        {
                            QuestionSixValueList.Add(responses.participant_answer);
                            valueCounter++;
                            QuestionSixValueCount.Add(valueCounter);
                        }
                        else
                        {
                            index = QuestionSixValueList.IndexOf(responses.participant_answer);
                            valueCounter = QuestionSixValueCount[index];
                            valueCounter++;
                            QuestionSixValueCount[index] = valueCounter;
                        }
                        valueCounter = 0;
                    }
                    // Same steps with question_id 2
                    else if (responses.question_id == 8)
                    {
                        if (QuestionEightValueList.Count < 1 || !QuestionEightValueList.Contains(responses.participant_answer))
                        {
                            QuestionEightValueList.Add(responses.participant_answer);
                            valueCounter++;
                            QuestionEightValueCount.Add(valueCounter);
                        }
                        else
                        {
                            index = QuestionEightValueList.IndexOf(responses.participant_answer);
                            valueCounter = QuestionEightValueCount[index];
                            valueCounter++;
                            QuestionEightValueCount[index] = valueCounter;
                        }
                        valueCounter = 0;
                    }
                    // Same steps with question_id 2
                    else if (responses.question_id == 9)
                    {
                        if (QuestionNineValueList.Count < 1 || !QuestionNineValueList.Contains(responses.participant_answer))
                        {
                            QuestionNineValueList.Add(responses.participant_answer);
                            valueCounter++;
                            QuestionNineValueCount.Add(valueCounter);
                        }
                        else
                        {
                            index = QuestionNineValueList.IndexOf(responses.participant_answer);
                            valueCounter = QuestionNineValueCount[index];
                            valueCounter++;
                            QuestionNineValueCount[index] = valueCounter;
                        }
                        valueCounter = 0;
                    }
                    // Same steps with question_id 2
                    else if (responses.question_id == 10)
                    {
                        if (QuestionTenValueList.Count < 1 || !QuestionTenValueList.Contains(responses.participant_answer))
                        {
                            QuestionTenValueList.Add(responses.participant_answer);
                            valueCounter++;
                            QuestionTenValueCount.Add(valueCounter);
                        }
                        else
                        {
                            index = QuestionTenValueList.IndexOf(responses.participant_answer);
                            valueCounter = QuestionTenValueCount[index];
                            valueCounter++;
                            QuestionTenValueCount[index] = valueCounter;
                        }
                        valueCounter = 0;
                    }
                }
                // Initialize finalReport POCO, assign designated list to each properties
                FinalReportPOCO finalReport = new FinalReportPOCO()
                {
                    QuestionTwoValueList = QuestionTwoValueList,
                    QuestionTwoValueCount = QuestionTwoValueCount,
                    QuestionThreeValueList = QuestionThreeValueList,
                    QuestionThreeValueCount = QuestionThreeValueCount,
                    QuestionFourValueList = QuestionFourValueList,
                    QuestionFourValueCount = QuestionFourValueCount,
                    QuestionFiveValueList = QuestionFiveValueList,
                    QuestionFiveValueCount = QuestionFiveValueCount,
                    QuestionSixValueList = QuestionSixValueList,
                    QuestionSixValueCount = QuestionSixValueCount,
                    QuestionNineValueList = QuestionNineValueList,
                    QuestionNineValueCount = QuestionNineValueCount,
                    QuestionTenValueList = QuestionTenValueList,
                    QuestionTenValueCount = QuestionTenValueCount,
                     QuestionEightValueList = QuestionEightValueList,
                    QuestionEightValueCount = QuestionEightValueCount,
                    SubmittedSurveyList = submittedSurveyList,
                    Question = Questions
                };
                // return finalReport POCO 
                return finalReport;
            }
        }               
    }
}
