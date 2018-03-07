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
#endregion
namespace FSOSS.System.BLL
{
    public class ReportController
    {
        public ReportPOCO GenerateOverAllReport(DateTime startDate, DateTime endDate, int siteID, int mealID)
        {
            using (var context = new FSOSSContext())
            {
                ReportPOCO reportList = new ReportPOCO();
                var submittedSurvey = (from x in context.SubmittedSurveys
                                       where x.date_entered >= startDate 
                                       && x.date_entered <= endDate 
                                       && x.Unit.site_id == siteID 
                                       && x.meal_id == mealID
                                       select x).ToList();

                var participantResponse = (from x in context.ParticipantResponses
                                           where x.submitted_survey_id == (submittedSurvey.FirstOrDefault(id => id.submitted_survey_id == x.submitted_survey_id).submitted_survey_id)
                                           select x).ToList();

            //    var question1 = (from x in participantResponse
            //                     where x.question_id == )

               return reportList;
            }     
        }
    }
}
