using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FSOSS.System.Data.Entity;
namespace FSOSS.System.Data.POCOs
{
    public class FinalReportPOCO
    {
        public List <SubmittedSurvey> SubmittedSurveyList { get; set; }
        public List<string> Question { get; set; } 
        public List<string> QuestionTwoValueList { get; set; }
        public List<int> QuestionTwoValueCount { get; set; }
        public List<string> QuestionThreeValueList { get; set; }
        public List<int> QuestionThreeValueCount { get; set; }
        public List<string> QuestionFourValueList { get; set; }
        public List<int> QuestionFourValueCount { get; set; }
        public List<string> QuestionFiveValueList { get; set; }
        public List<int> QuestionFiveValueCount { get; set; }
        public List<string> QuestionSixValueList { get; set; }
        public List<int> QuestionSixValueCount { get; set; }
        public List<string> QuestionNineValueList { get; set; }
        public List<int> QuestionNineValueCount { get; set; }
        public List<string> QuestionTenValueList { get; set; }
        public List<int> QuestionTenValueCount { get; set; }
        public List<string> QuestionEightValueList = new List<string>();
        public List<int> QuestionEightValueCount = new List<int>();
    }
}
