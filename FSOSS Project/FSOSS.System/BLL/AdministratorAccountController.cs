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
        public int GetUserID(string username)
        {
            int userID;
            using (var connection = new NpgsqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                connection.Open();
                var cmd = new NpgsqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "SELECT ADMINISTRATOR_ACCOUNT_ID" +
                                    " FROM ADMINISTRATOR_ACCOUNT" +
                                    " WHERE USERNAME = @p1";
                cmd.Parameters.AddWithValue("p1", username);
                userID = (int)cmd.ExecuteScalar();
                connection.Close();
            }
            return userID;
        }
        public int GetSecurityID(int userID)
        {
            int securityID;
            using (var connection = new NpgsqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                connection.Open();
                var cmd = new NpgsqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "SELECT SECURITY_ROLE_ID" +
                                    " FROM ADMINISTRATOR_ROLE" +
                                    " WHERE ADMINISTRATOR_ACCOUNT_ID = @p1";
                cmd.Parameters.AddWithValue("p1", userID);
                securityID = (int)cmd.ExecuteScalar();
                connection.Close();
            }
            return securityID;
        }
    }
}
