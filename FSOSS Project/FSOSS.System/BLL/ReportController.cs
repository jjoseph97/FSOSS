using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
#region
using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using FSOSS.System.Data.DTO;
#endregion
namespace FSOSS.System.BLL
{
    public class ReportController
    {
        public FinalReportPOCO GenerateOverAllReport(DateTime startDate, DateTime endDate, int siteID, int mealID)
        {
            using (var context = new FSOSSContext())
            {
                List<SubmittedSurvey> submittedSurveyList = (from x in context.SubmittedSurveys
                                                             where x.date_entered >= startDate && x.date_entered <= endDate
                                                             && x.meal_id == mealID
                                                             select x).ToList();

                List<ParticipantResponse> participantResponseList = (from x in context.ParticipantResponses
                                             where x.submittedsurvey.date_entered >= startDate
                                             && x.submittedsurvey.date_entered <= endDate
                                             && x.submittedsurvey.meal_id == mealID
                                             select x).ToList();
                           
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
                List<string> QuestionNineValueList = new List<string>();
                List<int> QuestionNineValueCount = new List<int>();
                List<string> QuestionTenValueList = new List<string>();
                List<int> QuestionTenValueCount = new List<int>();
                int valueCounter = 0;
                int index = 0;
                foreach (ParticipantResponse responses in participantResponseList)
                {
                    if (responses.question_id == 2)
                    {
                        if (QuestionTwoValueList.Count < 1 || !QuestionTwoValueList.Contains(responses.participant_answer))
                        {

                            QuestionTwoValueList.Add(responses.participant_answer);
                            valueCounter++;
                            QuestionTwoValueCount.Add(valueCounter);
                        }
                        else
                        {
                            index = QuestionTwoValueList.IndexOf(responses.participant_answer);
                            valueCounter = QuestionTwoValueCount[index];
                            valueCounter++;
                            QuestionTwoValueCount[index] = valueCounter;
                        }
                        valueCounter = 0;

                    }
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
                    submittedSurveyList = submittedSurveyList
                };
                return finalReport;
            }
        }
    }
}
