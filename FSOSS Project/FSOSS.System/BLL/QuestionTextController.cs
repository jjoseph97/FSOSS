using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace FSOSS.System.BLL
{
    [DataObject]
    public class QuestionTextController
    {

        /// <summary>
        /// Method used to get the string value for Question 1 where question_id in the database is 1 
        /// </summary>
        /// <returns>returns the string value for Question 1</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion1()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                             where x.question_id == 1
                             select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to get the string value for Question 1A where question_id in the database is 2
        /// </summary>
        /// <returns>returns the string value for Question 1A</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion1A()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                             where x.question_id == 2
                             select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to get the string value for Question 1B where question_id in the database is 3
        /// </summary>
        /// <returns>returns the string value for Question 1B</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion1B()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 3
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to get the string value for Question 1C where question_id in the database is 4 
        /// </summary>
        /// <returns>returns the string value for Question 1C</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion1C()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 4
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to get the string value for Question 1D where question_id in the database is 5
        /// </summary>
        /// <returns>returns the string value for Question 1D</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion1D()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 5
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to get the string value for Question 1E where question_id in the database is 6
        /// </summary>
        /// <returns>returns the string value for Question 1E</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion1E()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 6
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to get the string value for Question 2 where question_id in the database is 8 
        /// </summary>
        /// <returns>returns the string value for Question 2</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion2()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 8
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to get the string value for Question 3 where question_id in the database is 9
        /// </summary>
        /// <returns>returns the string value for Question 3</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion3()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 9
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to get the string value for Question 4 where question_id in the databse is 10
        /// </summary>
        /// <returns>returns the string value for Question 4</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion4()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 10
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to get the string value for Question 5 where question_id in the database is 11 
        /// </summary>
        /// <returns>returns the string value for Question 5</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestion5()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 11
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to return the string value for Gender where question_id in the database is 12
        /// </summary>
        /// <returns>returns the string value for Gender</returns> 
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestionGender()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 12
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to return the string value for Age Range where question_id in the database is 13
        /// </summary>
        /// <returns>returns the string value for Age Range</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestionAgeRange()
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id == 13
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }
        /// <summary>
        /// Method used to get the current question string value 
        /// </summary>
        /// <param name="question_id"></param>
        /// <returns>returns the string for each question</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestionText(int question_id)
        {
            using (var context = new FSOSSContext())
            {

                var result = (from x in context.Questions
                              where x.question_id.Equals(question_id)
                              select x.question_text).FirstOrDefault();
                return result;
            }
        }

        /// <summary>
        /// Method used to update the survey questions to return a new string 
        /// </summary>
        /// <param name="questionid"></param>
        /// <param name="text"></param>
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public void UpdateQuestionsText(int questionid, string text)
        {
            using (var context = new FSOSSContext())
            {
                Regex validResponse = new Regex("^[a-zA-Z ?.'/]+$");

                if (text.Length.Equals(0)) // if no question entered into field, display an error
                {
                    throw new Exception("Question text field can't be empty");
                }
                else if (text.Length > 100) // if question is not the correct length (100 characters or less), display an error 
                {
                    throw new Exception("Question must be 100 characters or less");
                }
                else if (!validResponse.IsMatch(text)) // if the response entered is not valid (numbers and special characters are entered), display an error
                {
                    throw new Exception("Please enter words with no numbers or special characters.");
                }
                var result = (from x in context.Questions
                              where x.question_id == questionid
                              select x).FirstOrDefault();

                result.question_text = text;

                context.SaveChanges();
            }
        }
    }
}
