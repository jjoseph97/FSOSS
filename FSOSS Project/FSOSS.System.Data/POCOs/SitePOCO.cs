﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSOSS.System.Data.POCOs
{
    public class SitePOCO
    {

        public int siteID { get; set; }
        public string siteName { get; set; }
        public DateTime dateModified { get; set; }
        public string username { get; set; }
        public int administrator_account_id { get; set; }
        public bool archived_yn { get; set; }

    }
}
