using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.BLL
{
    [DataObject]
    public class QuestionTextController
    {

        //Survey Questions 
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


        //Customer Profile
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

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetQuestionText(int question_id)
        {
            string questiontext;
            using (var connection = new NpgsqlConnection())
            {
               
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                connection.Open();
                var cmd = new NpgsqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "SELECT QUESTION_TEXT" +
                                    " FROM QUESTION" +
                                    " WHERE QUESTION_ID = @1";
                cmd.Parameters.AddWithValue("1", question_id);
                questiontext = cmd.ExecuteScalar().ToString();
                connection.Close();
            }
            return questiontext;
        }



        //select question_text from question where question_id = 1;
    }
}
