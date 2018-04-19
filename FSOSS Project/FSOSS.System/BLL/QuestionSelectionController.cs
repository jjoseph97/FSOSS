using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace FSOSS.System.BLL
{
    [DataObject]
    public class QuestionSelectionController
    {
        //TakeSurvey.aspx and TakeSurvey.aspx.cs
        //method used to get the response string value for Question 1A
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1AReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                                where x.question_id == 2
                                orderby x.question_selection_id
                                select new ResponsePOCO
                                {
                                    Text = x.question_selection_text,
                                    Value = x.question_selection_value
                                };
                return result.ToList();
            }
        }

        //method used to get the response string value for Question 1B
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1BReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                                where x.question_id == 3
                                orderby x.question_selection_id
                                select new ResponsePOCO
                                {
                                    Text = x.question_selection_text,
                                    Value = x.question_selection_value
                                };
                return result.ToList();
            }
        }

        //method used to get the response string value Question 1C
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1CReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                                where x.question_id == 4
                                orderby x.question_selection_id
                                select new ResponsePOCO
                                {
                                    Text = x.question_selection_text,
                                    Value = x.question_selection_value
                                };
                return result.ToList();
            }
        }

        //method used to get the response string value for Question 1D
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1DReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                                where x.question_id == 5
                                orderby x.question_selection_id
                                select new ResponsePOCO
                                {
                                    Text = x.question_selection_text,
                                    Value = x.question_selection_value
                                };
                return result.ToList();
            }
        }

        //method used to get the response string value for Question 1E
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion1EReponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                                where x.question_id == 6
                                orderby x.question_selection_id
                                select new ResponsePOCO
                                {
                                    Text = x.question_selection_text,
                                    Value = x.question_selection_value
                                };
                return result.ToList();
            }
        }

        //method used to get the response string value for Question 2
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion2Reponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                                where x.question_id == 8
                                orderby x.question_selection_id
                                select new ResponsePOCO
                                {
                                    Text = x.question_selection_text,
                                    Value = x.question_selection_value
                                };
                return result.ToList();
            }
        }

        //method used to get the response string value for Question 3
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion3Reponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                                where x.question_id == 9
                                orderby x.question_selection_id
                                select new ResponsePOCO
                                {
                                    Text = x.question_selection_text,
                                    Value = x.question_selection_value
                                };
                return result.ToList();
            }
        }

        //method used to get the response string value for Question 4
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestion4Reponse()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                                where x.question_id == 10
                                orderby x.question_selection_id
                                select new ResponsePOCO
                                {
                                    Text = x.question_selection_text,
                                    Value = x.question_selection_value
                                };
                return result.ToList();
            }
        }

        //Edit Survey Questions Page
        //Method used to display current survey responses
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ResponsePOCO> GetQuestionResponses(int questionid)
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.QuestionSelections
                             where x.question_id == questionid
                             orderby x.question_selection_id
                             select new ResponsePOCO
                             {
                                 ResponseId = x.question_selection_id,
                                 Text = x.question_selection_text,
                                 Value = x.question_selection_value
                             };
                return result.ToList();
            }
        }

        //Update survey responses to return new string 
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateQuestionResponses(int questionid, int ResponseId, string text, string value, string strQuestion)
        {
            string message = "";
            using (var context = new FSOSSContext())
            {
                Regex validResponse = new Regex("^[a-zA-Z ?.'/]+$");

                if (text.Length.Equals(0))
                {
                    throw new Exception("Edit field can't be empty");
                }
                else if (text.Length > 100)
                {
                    throw new Exception("Response must be 100 characters or less");
                }
                else if (!validResponse.IsMatch(text))
                {
                    throw new Exception("Please enter words with no numbers or special characters.");
                }
                var result = (from x in context.QuestionSelections
                             where x.question_id == questionid && x.question_selection_id == ResponseId
                             select x).FirstOrDefault();

                result.question_selection_text = text;
                result.question_selection_value = text;

                context.SaveChanges();

                return message = "Successfully updated response for " + strQuestion;
            }
        }
    }
}
