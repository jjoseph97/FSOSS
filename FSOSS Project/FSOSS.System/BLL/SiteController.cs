using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using System.Text.RegularExpressions;
using System.Data.Entity;

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
                                   where !x.archived_yn
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

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public int GetSiteID(string sitename)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var siteID = (from x in context.Sites
                                  where x.site_name.StartsWith(sitename)
                                  select x.site_id).FirstOrDefault();
                    return siteID;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddSite(string newSiteName, int employee) // add a new site to the database.
        {
            using (var context = new FSOSSContext())
            {
                string message = "";

                try
                {
                    //check to see if the site already exists in the database
                    var siteList = from x in context.Sites
                                   where x.site_name.ToLower().Equals(newSiteName.ToLower())
                                   select new SitePOCO()
                                   {
                                       siteName = x.site_name
                                   };
                    if (siteList.Count() > 0) //if so, return an error message
                    {
                        message = "The site \"" + newSiteName.ToLower() + "\" already exists. Please enter a new site.";
                    }
                    else //otherwise enter new site into the database
                    {
                        Site newSite = new Site();
                        newSite.administrator_account_id = employee;
                        newSite.site_name = newSiteName.Trim();
                        newSite.date_modified = DateTime.Now;
                        newSite.archived_yn = false;
                        context.Sites.Add(newSite);
                        context.SaveChanges();

                        message = "Successfully added the new site: \"" + newSiteName + "\"";

                    }
                }
                catch (Exception e)
                {
                    message = "Oops, something went wrong. Check " + e.Message;
                }
                return message;
            } //end of using var context
                
        } // end of Addsite

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateSite(Site item) //currently for active sites only
        {
            using (var context = new FSOSSContext())
            {
                Regex valid = new Regex("^[a-zA-Z ]+$");
                string message = "";
                try
                {
                    //context.Entry(item).State = EntityState.Modified;
                    //context.SaveChanges();
                    //return message;
                
                //var siteList = (from x in context.Sites
                //                where x.is_closed_yn == false && x.site_id == item.site_id
                //                      select new Site
                //                      {
                //                          siteID = x.site_id,
                //                          siteName = x.site_name,
                //                          administrator_account_id = x.administrator_account_id,
                //                          date_modified = x.date_modified

                //                      }).FirstOrDefault();

                    if (valid.IsMatch(item.site_name))
                    {
                        var exists = (from x in context.Sites
                                      where x.archived_yn == false && x.site_id == item.site_id
                                      select x);
                        if (exists == null)
                        {
                            throw new Exception("This hospital is not open.");
                        }
                        else
                        {
                            Site updateSite = context.Sites.Find(item.site_id);
                            updateSite.site_name = item.site_name.Trim();
                            updateSite.date_modified = DateTime.Now;

                            context.Entry(updateSite).State = EntityState.Modified;
                        }

                        context.SaveChanges();
                    }
                    else
                    {
                        throw new Exception("Update failed.");
                    }
                }
                catch (Exception e)
                {
                    message = e.Message;
                }
                return message;
            }
        }
    }
}
