using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.BLL
{
    [DataObject]
    public class QuestionSelectionController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestionReponse(int question_id)
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == question_id
                             select new ResponsePOCO
                             {
                                 Text = x.question_selection_text,
                                 Value = x.question_selection_value
                             };
                return result.ToList();
            }
        }
    }
}
