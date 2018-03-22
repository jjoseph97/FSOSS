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
        public List<SubmittedSurvey> GenerateOverAllReport(DateTime startDate, DateTime endDate, int siteID, int mealID)
        {
            using (var context = new FSOSSContext())
            {
                  var submittedSurveyList = (from x in context.SubmittedSurveys
                                             where x.date_entered >= startDate
                                             && x.date_entered <= endDate
                                             && x.meal_id == mealID
                                             select x).ToList();
                   
                return submittedSurveyList;
            }
        }
    }
}
