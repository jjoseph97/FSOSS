using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class AnswerPOCO
    {
        public int submitted_survey_id { get; set; }
        public int question_id { get; set; }
        public string answer { get; set; }
    }
}
