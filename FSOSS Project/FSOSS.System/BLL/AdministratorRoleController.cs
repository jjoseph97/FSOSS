using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
#region
using FSOSS.System.DAL;
using FSOSS.System.Data.Entity;
#endregion
namespace FSOSS.System.BLL
{
    public class AdministratorRoleController
    {
        /// <summary>
        /// Method is used to retrieve the Administrator Role class based on the Administrator Account ID
        /// </summary>
        /// <param name="accountID"></param>
        /// <returns>returns the Administrator Role class</returns>
        public AdministratorRole GetAdministratorRole(int accountID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    AdministratorRole administratorRole = (from x in context.AdministratorRoles
                                                           where x.administrator_account_id == accountID
                                                           select x).FirstOrDefault();
                   return administratorRole;
                } 
                catch(Exception e)
                {
                    throw new Exception(e.Message);
                }
                
            }
                
        }
    }
}
