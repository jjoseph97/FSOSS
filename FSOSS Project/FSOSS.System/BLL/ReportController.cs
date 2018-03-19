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
        public FinalReportDTO GenerateOverAllReport(DateTime startDate, DateTime endDate, int siteID, int mealID)
        {
            using (var context = new FSOSSContext())
            {
                // get all version
                var allSurveyVersions = (from x in context.SurveyVersions
                                         select x).AsQueryable();

                // get latest version
                var surveyVersion = (from x in context.SurveyVersions
                                     where x.start_date == allSurveyVersions.Where(finalDate => finalDate.end_date.Equals(null))
                                                                            .Max(latestDate => latestDate.start_date)
                                     select x).ToList().FirstOrDefault();

                // get the submitted survey with matching criteria
                var reportDTO = (from x in context.SubmittedSurveys
                                 where x.date_entered >= startDate
                                 && x.date_entered <= endDate
                                 && x.Unit.site_id == siteID
                                 && x.meal_id == mealID
                                 && x.survey_version_id == surveyVersion.survey_version_id
                                 select new ReportDTO
                                 {
                                     age_range_id = x.age_range_id,
                                     date_entered = x.date_entered,
                                     unit_id = x.unit_id,
                                     meal_id = x.meal_id,
                                     gender_id = x.gender_id,
                                     participant_type_id = x.participant_type_id,
                                     survey_version_id = x.survey_version_id,
                                     participantAnswerList = (from y in context.ParticipantResponses
                                                              where (x.participant_responses.Any(z => z.submitted_survey_id == y.submitted_survey_id)) 
                                                              && (y.question.question_id != 2 || y.question.question_id != 3 || y.question.question_id != 6 
                                                              || y.question.question_id != 8 || y.question.question_id != 9 || y.question.question_id != 10 ||
                                                              y.question.question_id != 11)
                                                              group y by y.question_id into s
                                                              select new AnswerPOCO
                                                              {
                                                                  totalQuestionResponseCount = s.Count(),
                                                                  //not sure if this syntax/logic is correct
                                                                  answer = s.Select(t => t.participant_answer).FirstOrDefault(),
                                                                  question_id = s.Select(t => t.question_id).FirstOrDefault(),
                                                                  submitted_survey_id = s.Select(t => t.submitted_survey_id).FirstOrDefault(),
                                                                  answerCount = s.GroupBy(t => t.participant_answer).Count()
                                                              }).ToList(),
                                     reportQuestionList = (from z in context.Questions
                                                           where z.question_id != 2 || z.question_id != 3 || z.question_id != 6 || z.question_id != 8 
                                                           || z.question_id != 9 || z.question_id != 10 || z.question_id != 11                                                           
                                                           select new ReportQuestionPOCO
                                                           {
                                                               question_id = z.question_id,
                                                               question_text = z.question_text
                                                           }).ToList()
                                 }).ToList();


                FinalReportDTO finalReportDTO = new FinalReportDTO(){ submittedSurveyList = reportDTO }; 



                return finalReportDTO;
            }
        }
    }
}
