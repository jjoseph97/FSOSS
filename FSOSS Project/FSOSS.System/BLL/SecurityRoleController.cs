using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.BLL
{
    [DataObject]
    public class SecurityRoleController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<SecurityRolePOCO> GetSecurityRoleList()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.SecurityRoles
                             select new SecurityRolePOCO()
                             {
                                 securityID = x.security_role_id,
                                 securityDescription = x.security_description
                             };

                return result.ToList();
            }
        }
    }
}
