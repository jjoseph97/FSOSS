using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using FSOSS.System.Data.POCOs;

namespace FSOSS.System.Data.DTO
{
    public class ReportDTO
    {
        public int survey_version_id { get; set; }
        public int unit_id { get; set; }
        public int meal_id { get; set; }
        public int participant_type_id { get; set; }
        public int age_range_id { get; set; }
        public int gender_id { get; set; }
        public DateTime date_entered { get; set; }

        public List<AnswerPOCO> participantAnswerList { get; set; }
        public List<ReportQuestionPOCO> reportQuestionList { get; set; }
    }
}
