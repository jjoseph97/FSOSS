using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FSOSS.System.Data.Entity;
namespace FSOSS.System.Data.POCOs
{
    public class AnswerPOCO
    {
        public int totalQuestionResponseCount { get; set; }
        public int submitted_survey_id { get; set; }
        public int question_id { get; set; }
        public string answer { get; set; }
        public int answerCount { get; set; }
        
    }
}
