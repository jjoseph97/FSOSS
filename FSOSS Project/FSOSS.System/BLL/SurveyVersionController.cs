using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region
using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
#endregion

namespace FSOSS.System.BLL
{
    public class SurveyVersionController
    {
        /// <summary>
        /// Method use for getting the latest survey version
        /// </summary>
        /// <returns>Latest survey version</returns>
        public SurveyVersion GetLatestSurvey()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    SurveyVersion surveyVersion = new SurveyVersion();
                    surveyVersion = (from x in context.SurveyVersions
                                     where x.start_date == context.SurveyVersions.Where(endDate => endDate.end_date.Equals(null))
                                                                            .Max(latestDate => latestDate.start_date)
                                     select x).FirstOrDefault();

                    return surveyVersion;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                } 
            }      
        }
    }
}
