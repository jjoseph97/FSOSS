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
        //Question 1A
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1AReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == 2
                             select new ResponsePOCO
                             {
                                 Text = x.question_selection_text,
                                 Value = x.question_selection_value
                             };
                return result.ToList();
            }
        }

        //Question 1B
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1BReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == 3
                             select new ResponsePOCO
                             {
                                 Text = x.question_selection_text,
                                 Value = x.question_selection_value
                             };
                return result.ToList();
            }
        }

        //Question 1C
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1CReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == 4
                             select new ResponsePOCO
                             {
                                 Text = x.question_selection_text,
                                 Value = x.question_selection_value
                             };
                return result.ToList();
            }
        }

        //Question 1D
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1DReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == 5
                             select new ResponsePOCO
                             {
                                 Text = x.question_selection_text,
                                 Value = x.question_selection_value
                             };
                return result.ToList();
            }
        }

        //Question 1E
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1EReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == 6
                             select new ResponsePOCO
                             {
                                 Text = x.question_selection_text,
                                 Value = x.question_selection_value
                             };
                return result.ToList();
            }
        }

        //Question 2
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion2Reponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == 8
                             select new ResponsePOCO
                             {
                                 Text = x.question_selection_text,
                                 Value = x.question_selection_value
                             };
                return result.ToList();
            }
        }

        //Question 3
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion3Reponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == 9
                             select new ResponsePOCO
                             {
                                 Text = x.question_selection_text,
                                 Value = x.question_selection_value
                             };
                return result.ToList();
            }
        }

        //Question 4
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion4Reponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == 10
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
