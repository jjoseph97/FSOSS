using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FSOSS.System.DAL;
using Npgsql;

namespace FSOSS.System.BLL
{
    public class AdministratorAccountController
    {
        public bool VerifyLogin(string username, string password)
        {
            bool isValid;
            using (var connection = new NpgsqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                connection.Open();
                var cmd = new NpgsqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "SELECT (ADMIN_PASSWORD = crypt(@p1, ADMIN_PASSWORD)) as isValid" +
                                    " FROM ADMINISTRATOR_ACCOUNT" +
                                    " WHERE USERNAME = @p2";
                cmd.Parameters.AddWithValue("p1", password);
                cmd.Parameters.AddWithValue("p2", username.ToLower());
                isValid = cmd.ExecuteReader().Read();
                connection.Close();
            }
            return isValid;
        }
    }
}
