using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using Npgsql;

namespace FSOSS.System.BLL
{
    [DataObject]
    public class AdministratorAccountController
    {
        /// <summary>
        /// Method used to verify the Administrator Account is active prior to logging in
        /// </summary>
        /// <param name="username"></param>
        /// <returns>returns a boolean value of true or false</returns>
        public bool AdministratorAccountIsActive(string username)
        {
            using (var context = new FSOSSContext())
            {
                // Use Linq query to retrieve a count where user is active
                var result = (from x in context.AdministratorAccounts
                              where !x.archived_yn && username.Equals(x.username)
                              select x).Count();

                // Return false if the count equals 0; else return true
                return result.Equals(0) ? false : true;
            }
        }
        /// <summary>
        /// Method used to verify login credentials
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public bool VerifyLogin(string username, string password)
        {
            // Declare a local variable
            bool isValid;

            // Make a connection to the database to use stored procedures
            using (var connection = new NpgsqlConnection())
            {
                try
                {
                    // Acquire a connection string from the Configuration Manager class
                    connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                    // Open the connection
                    connection.Open();
                    // Call the stored procedure "password_is_valid". NOTE: the name is case sensitive
                    var cmd = new NpgsqlCommand("password_is_valid", connection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    // Pass in the parameters required for the stored procedures
                    cmd.Parameters.AddWithValue("username_param", username);
                    cmd.Parameters.AddWithValue("password_param", password);
                    // Execute the query
                    isValid = (Boolean)cmd.ExecuteScalar();
                    // Close the connection
                    connection.Close();
                }
                catch
                {
                    // Return false if bad connection
                    isValid = false;
                }
            }
            return isValid;
        }
        /// <summary>
        /// Method used to retrieve the Administrator Account ID
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public int GetAdministratorAccountID(string username)
        {
            using (var context = new FSOSSContext())
            {
                // Use Linq query to retrieve Administrator Account ID
                var result = (from x in context.AdministratorAccounts
                              where x.username.Equals(username.ToLower())
                              select x.administrator_account_id).FirstOrDefault();

                return result;
            }
        }
        /// <summary>
        /// Method is used to add a new Administrator Account
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <param name="firstname"></param>
        /// <param name="lastname"></param>
        /// <param name="securityId"></param>
        /// <returns>returns the new username created</returns>
        public string AddAdministratorAccount(string username, string password, string firstname, string lastname, int securityId)
        {
            using (var context = new FSOSSContext())
            {
                // Use Linq query to retrieve a count of usernames that start with the same string
                var result = (from x in context.AdministratorAccounts
                              where x.username.StartsWith(username)
                              select x).Count();

                // Add the count to the new username if the count is greater than 0 to ensure username is unique
                if (result > 0)
                    username = username + result;
            }
            // Make a connection to the database to use stored procedures
            using (var connection = new NpgsqlConnection())
            {
                // Acquire a connection string from the Configuration Manager class
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                // Open the connection
                connection.Open();

                // Call the stored procedure "add_user". NOTE: the name is case sensitive
                var cmd = new NpgsqlCommand("add_user", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                // Pass in the parameters required for the stored procedures
                cmd.Parameters.AddWithValue("username_param", username);
                cmd.Parameters.AddWithValue("password_param", password);
                cmd.Parameters.AddWithValue("firstname_param", firstname);
                cmd.Parameters.AddWithValue("lastname_param", lastname);
                cmd.Parameters.AddWithValue("securityid_param", securityId);
                // Execute the query
                string newUsername = cmd.ExecuteScalar().ToString();
                // Close the connection
                connection.Close();
                // Return the new username retrieved from the stored procedure
                return newUsername;
            }
        }
        /// <summary>
        /// Method used to retrieve all Administrator Accounts
        /// </summary>
        /// <returns>returns a list of Administrator Accounts</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<AdministratorAccountPOCO> GetAllAdministratorAccountList()
        {
            using (var context = new FSOSSContext())
            {
                // Use Linq query to store attributes into the AdministratorAccountPOCO class
                var result = from x in context.AdministratorAccounts
                             orderby x.username ascending
                             select new AdministratorAccountPOCO
                             {
                                 id = x.administrator_account_id,
                                 username = x.username,
                                 firstName = x.first_name,
                                 lastName = x.last_name,
                                 archived = x.archived_yn == true ? "Deactive" : "Active"
                             };

                return result.ToList();
            }
        }
        /// <summary>
        /// Method used to retrieve searched Administrator Account
        /// </summary>
        /// <param name="searchedWord"></param>
        /// <returns>returns a list of searched Administrator Account(s)</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<AdministratorAccountPOCO> GetSearchedAdministratorAccountList(string searchedWord)
        {
            using (var context = new FSOSSContext())
            {
                // Use Linq query to store attributes into the AdministratorAccountPOCO class based on search conditions
                var result = from x in context.AdministratorAccounts
                             orderby x.username ascending
                             where x.username.Contains(searchedWord.Trim().ToLower()) // Search for username
                                || x.first_name.ToLower().Contains(searchedWord.Trim().ToLower()) // Search for First Name
                                || x.last_name.ToLower().Contains(searchedWord.Trim().ToLower()) // Search for Last Name
                             select new AdministratorAccountPOCO
                             {
                                 id = x.administrator_account_id,
                                 username = x.username,
                                 firstName = x.first_name,
                                 lastName = x.last_name,
                                 archived = x.archived_yn == true ? "Inactive" : "Active"
                             };

                return result.ToList();
            }
        }
        /// <summary>
        /// Method used to retrieve Administrator Account Information
        /// </summary>
        /// <param name="administratorID"></param>
        /// <returns>returns a class of AdministratorAccountPOCO</returns>
        public AdministratorAccountPOCO GetAdministratorInformation(int administratorID)
        {
            using (var context = new FSOSSContext())
            {
                // Use Linq query to store attributes into the AdministratorAccountPOCO class
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
        /// <summary>
        /// Overloaded Method used to update the Administrator Account password
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <param name="firstname"></param>
        /// <param name="lastname"></param>
        /// <param name="archive"></param>
        /// <param name="selectedRoleId"></param>
        /// <returns>returns the username for confirmation</returns>
        public string UpdateAdministratorAccount(string username, string password, string firstname, string lastname, bool archive, int selectedRoleId)
        {
            // Make a connection to the database to use stored procedures
            using (var connection = new NpgsqlConnection())
            {
                // Acquire a connection string from the Configuration Manager class
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                // Open the connection
                connection.Open();
                // Call the stored procedure "update_user_with_password". NOTE: the name is case sensitive
                var cmd = new NpgsqlCommand("update_user_with_password", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                // Pass in the parameters required for the stored procedures
                cmd.Parameters.AddWithValue("username_param", username);
                cmd.Parameters.AddWithValue("password_param", password);
                cmd.Parameters.AddWithValue("firstname_param", firstname);
                cmd.Parameters.AddWithValue("lastname_param", lastname);
                cmd.Parameters.AddWithValue("archived_yn_param", archive);
                cmd.Parameters.AddWithValue("securityid_param", selectedRoleId);
                // Execute the query
                string updatedUser = cmd.ExecuteScalar().ToString();
                // Close the connection
                connection.Close();
                return updatedUser;
            }
        }
        /// <summary>
        /// Overloaded Method used to update the Administrator Account information
        /// </summary>
        /// <param name="username"></param>
        /// <param name="firstname"></param>
        /// <param name="lastname"></param>
        /// <param name="archive"></param>
        /// <param name="selectedRoleId"></param>
        /// <returns>returns the username for confirmation</returns>
        public string UpdateAdministratorAccount(string username, string firstname, string lastname, bool archive, int selectedRoleId)
        {
            // Make a connection to the database to use stored procedures
            using (var connection = new NpgsqlConnection())
            {
                // Acquire a connection string from the Configuration Manager class
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["FSOSSConnectionString"].ToString();
                // Open the connection
                connection.Open();
                // Call the stored procedure "update_user_without_password". NOTE: the name is case sensitive
                var cmd = new NpgsqlCommand("update_user_without_password", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                // Pass in the parameters required for the stored procedures
                cmd.Parameters.AddWithValue("username_param", username);
                cmd.Parameters.AddWithValue("firstname_param", firstname);
                cmd.Parameters.AddWithValue("lastname_param", lastname);
                cmd.Parameters.AddWithValue("archived_yn_param", archive);
                cmd.Parameters.AddWithValue("securityid_param", selectedRoleId);
                // Execute the query
                string updatedUser = cmd.ExecuteScalar().ToString();
                // Close the connection
                connection.Close();
                return updatedUser;
            }
        }
    }
}
