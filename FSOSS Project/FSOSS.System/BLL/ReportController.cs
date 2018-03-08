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
        public List<ReportDTO> GenerateOverAllReport(DateTime startDate, DateTime endDate, int siteID, int mealID)
        {
            using (var context = new FSOSSContext())
            {
                // get all version
                var allSurveyVersions = (from x in context.SurveyVersions
                                         select x).ToList();

                // get latest version
                var surveyVersion = (from x in context.SurveyVersions
                                     where x.start_date == allSurveyVersions.Where(finalDate => finalDate.end_date.Equals(null))
                                                                            .Max(latestDate => latestDate.start_date)
                                     select x).FirstOrDefault();

                // get the submitted survey with matching criteria
                var reportDTO = (from x in context.SubmittedSurveys
                                 where x.date_entered >= startDate
                                 && x.date_entered <= endDate
                                 && x.Unit.site_id == siteID
                                 && x.meal_id == mealID
                                 && x.survey_version_id == surveyVersion.version_id
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
                                                              where x.participant_responses.Any(z => z.submitted_survey_id == y.submitted_survey_id)
                                                              select new AnswerPOCO
                                                              {
                                                                  answer = y.participant_answer,
                                                                  question_id = y.question_id,
                                                                  submitted_survey_id = y.submitted_survey_id
                                                              }).ToList()
                                 }).ToList();
                return reportDTO;
            }
        }
    }
}
