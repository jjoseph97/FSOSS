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
