using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
                try
                {
                    connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                    connection.Open();
                    var cmd = new NpgsqlCommand("password_is_valid", connection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("username_param", username);
                    cmd.Parameters.AddWithValue("password_param", password);
                    isValid = (Boolean)cmd.ExecuteScalar();
                    connection.Close();
                }
                catch
                {
                    isValid = false;
                }
            }
            return isValid;
        }

        public int GetUserID(string username)
        {
            using (var context = new FSOSSContext())
            {
                var result = (from x in context.AdministratorAccounts
                              where x.username.Equals(username.ToLower())
                              select x.administrator_account_id).FirstOrDefault();

                return result;
            }
        }

        public int GetSecurityID(int userID)
        {
            using (var context = new FSOSSContext())
            {
                var result = (from x in context.AdministratorRoles
                              where x.administrator_account_id.Equals(userID)
                              select x.security_role_id).FirstOrDefault();

                return result;
            }
        }
    }
}
