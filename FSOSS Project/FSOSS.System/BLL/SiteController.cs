﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;

//created March 8 2018-c
namespace FSOSS.System.BLL
{
    [DataObject]
    public class SiteController
    {


        //obtain list of all not closed sites
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<SitePOCO> GetSiteList()
        {
            using (var context= new FSOSSContext())
            {
                try
                {
                    var siteList = from x in context.Sites
                                   where !x.is_closed_yn
                                   select new SitePOCO()
                                   {
                                       siteID = x.site_id,
                                       siteName = x.site_name
                                   };

                    return siteList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
    }
}