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
        /// <summary>
        /// Method used to get the response string value for Question 1A where question_id in the database is 2.
        /// </summary>
        /// <returns>returns a list from the ResponsePOCO with the text and value</returns>
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

        /// <summary>
        /// Method used to get the response string value for Question 1B where question_id in the database is 3.
        /// </summary>
        /// <returns>returns a list from the ResponsePOCO with the text and value</returns>
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

        /// <summary>
        /// Method used to get the response string value for Question 1C where question_id in the database is 4.
        /// </summary>
        /// <returns>returns a list from the ResponsePOCO with the text and value</returns>
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

        /// <summary>
        /// Method used to get the response string value for Question 1D where question_id in the database is 5. 
        /// </summary>
        /// <returns>returns a list from the ResponsePOCO with the text and value</returns>
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

        /// <summary>
        /// Method used to get the response string value for Question 1E where question_id in the database is 6.
        /// </summary>
        /// <returns>returns a list from the ResponsePOCO with the text and value</returns>
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
        
        /// <summary>
        /// Method used to get the response string value for Question 2 where question_id in the database is 8.
        /// </summary>
        /// <returns>returns a list from the ResponsePOCO with the text and value</returns>
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

        /// <summary>
        /// Method used to get the response string value for Question 3 where question_id in the database is 9.
        /// </summary>
        /// <returns>returns a list from the ResponsePOCO with the text and value</returns>
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
        
        /// <summary>
        /// Method used to get the response string value for Question 4 where question_id in the database is 10.
        /// </summary>
        /// <returns>returns a list from the ResponsePOCO with the text and value</returns>
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

        /// <summary>
        /// Method used to display current survey responses
        /// </summary>
        /// <param name="questionid"></param>
        /// <returns>returns a list from the ResponsePOCO with the responseid, text and value</returns>
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

        /// <summary>
        /// Method used to update current survey responses 
        /// </summary>
        /// <param name="questionid"></param>
        /// <param name="ResponseId"></param>
        /// <param name="text"></param>
        /// <param name="value"></param>
        /// <param name="strQuestion"></param>
        /// <returns>returns a confirmation that a response is updated</returns> 
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateQuestionResponses(int questionid, int ResponseId, string text, string value, string strQuestion)
        {
            string message = "";
            using (var context = new FSOSSContext())
            {
                Regex validResponse = new Regex("^[a-zA-Z ?.'/]+$");

                if (text.Length.Equals(0)) //if no response is entered, display an error
                {
                    throw new Exception("Edit field can't be empty");
                }
                else if (text.Length > 100) //if response is not the correct length (100 characters or less), display an error
                {
                    throw new Exception("Response must be 100 characters or less");
                }
                else if (!validResponse.IsMatch(text)) //if the response entered is not valid (special characters or numbers entered), display an error
                {
                    throw new Exception("Please enter words with no numbers or special characters.");
                }
                //select a question selection (response) where question_id = questionid and question_selection_id = responseid 
                var result = (from x in context.QuestionSelections
                             where x.question_id == questionid && x.question_selection_id == ResponseId
                             select x).FirstOrDefault();

                //new response text and value is assigned
                result.question_selection_text = text;
                result.question_selection_value = text;

                context.SaveChanges();

                return message = "Successfully updated response for " + strQuestion;
            }
        }
    }
}
