using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class AdministratorAccountPOCO
    {
        public int id { get; set; }
        public string username { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string archived { get; set; }
        public bool archivedBool { get; set; }
        public int roleId { get; set; }
    }
}
