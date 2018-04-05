using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using Npgsql;

namespace FSOSS.System.BLL
{
    [DataObject]
    public class AdministratorAccountController
    {
        public bool UserIsActive(string username)
        {
            using (var context = new FSOSSContext())
            {
                var result = (from x in context.AdministratorAccounts
                              where !x.archived_yn && username.Equals(x.username)
                              select x).Count();

                return result.Equals(0) ? false : true;
            }
        }
        public bool UserExists(string username)
        {
            using (var context = new FSOSSContext())
            {
                return context.AdministratorAccounts.Any(e => e.username.Equals(username));
            }
        }
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

        public string AddUser(string username, string password, string firstname, string lastname, int selectedRoleId)
        {
            using (var context = new FSOSSContext())
            {
                var result = (from x in context.AdministratorAccounts
                              where x.username.StartsWith(username)
                              select x).Count();

                if (result > 0)
                    username = username + result;
            }
            using (var connection = new NpgsqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                connection.Open();
                var cmd = new NpgsqlCommand("add_user", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("username_param", username);
                cmd.Parameters.AddWithValue("password_param", password);
                cmd.Parameters.AddWithValue("firstname_param", firstname);
                cmd.Parameters.AddWithValue("lastname_param", lastname);
                cmd.Parameters.AddWithValue("securityid_param", selectedRoleId);
                string newUsername = cmd.ExecuteScalar().ToString();
                connection.Close();
                return newUsername;
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<AdministratorAccountPOCO> GetAllUserList()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.AdministratorAccounts
                             orderby x.username ascending
                             select new AdministratorAccountPOCO
                             {
                                 id = x.administrator_account_id,
                                 username = x.username,
                                 firstName = x.first_name,
                                 lastName = x.last_name,
                                 archived = x.archived_yn == true ? "Disabled" : "Enabled"
                             };

                return result.ToList();
            }
        }

        public AdministratorAccountPOCO GetAdministratorInformation(int administratorID)
        {
            using (var context = new FSOSSContext())
            {
                var result = (from x in context.AdministratorRoles
                             where x.administratoraccount.administrator_account_id == administratorID
                             select new AdministratorAccountPOCO
                             {
                                 username = x.administratoraccount.username,
                                 firstName = x.administratoraccount.first_name,
                                 lastName = x.administratoraccount.last_name,
                                 archivedBool = x.administratoraccount.archived_yn,
                                 roleId = x.security_role_id,
                             }).FirstOrDefault();

                return result;
            }
        }
        // TODO: Rameses - Ensure RedoScript is updated with new functions
        public string UpdateAdministratorAccount(string username, string password, string firstname, string lastname, bool archive, int selectedRoleId)
        {
            #region DOES NOT WORK
            //using (var context = new FSOSSContext())
            //{
            //    var result = (from x in context.AdministratorAccounts
            //                  where x.username.Equals(username)
            //                  select x).FirstOrDefault();

            //    result.first_name = firstName;
            //    result.last_name = lastName;
            //    result.archived_yn = archive;
            //    result.date_modified = DateTime.Now;

            //    context.Entry(result).Property(y => y.first_name).IsModified = true;
            //    context.Entry(result).Property(y => y.last_name).IsModified = true;
            //    context.Entry(result).Property(y => y.archived_yn).IsModified = true;
            //    context.Entry(result).Property(y => y.date_modified).IsModified = true;

            //    var rename = (from y in context.AdministratorRoles
            //                  where y.administrator_account_id.Equals(result.administrator_account_id)
            //                  select y).FirstOrDefault();

            //    //rename.security_role_id = securityRoleId; // does not like this code due to it being a primary key...?
            //    rename.date_modified = DateTime.Now;

            //    //context.Entry(rename).Property(y => y.security_role_id).IsModified = true;
            //    context.Entry(rename).Property(y => y.date_modified).IsModified = true;

            //    context.SaveChanges();

            //}
            #endregion
            using (var connection = new NpgsqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                connection.Open();
                var cmd = new NpgsqlCommand("update_user_with_password", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("username_param", username);
                cmd.Parameters.AddWithValue("password_param", password);
                cmd.Parameters.AddWithValue("firstname_param", firstname);
                cmd.Parameters.AddWithValue("lastname_param", lastname);
                cmd.Parameters.AddWithValue("archived_yn_param", archive);
                cmd.Parameters.AddWithValue("securityid_param", selectedRoleId);
                string updatedUser = cmd.ExecuteScalar().ToString();
                connection.Close();
                return updatedUser;
            }
        }
        public string UpdateAdministratorAccount(string username, string firstname, string lastname, bool archive, int selectedRoleId)
        {
            using (var connection = new NpgsqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                connection.Open();
                var cmd = new NpgsqlCommand("update_user_without_password", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("username_param", username);
                cmd.Parameters.AddWithValue("firstname_param", firstname);
                cmd.Parameters.AddWithValue("lastname_param", lastname);
                cmd.Parameters.AddWithValue("archived_yn_param", archive);
                cmd.Parameters.AddWithValue("securityid_param", selectedRoleId);
                string updatedUser = cmd.ExecuteScalar().ToString();
                connection.Close();
                return updatedUser;
            }
        }
    }
}
