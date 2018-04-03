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
                                   orderby x.site_name ascending
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

        //get closed sites
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<SitePOCO> GetArchived()
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    var archived = from x in context.Sites
                                           where x.archived_yn == true
                                           orderby x.site_name ascending
                                           select new SitePOCO()
                                           {
                                               siteID = x.site_id,
                                               siteName = x.site_name,
                                               date_modified = x.date_modified
                                           };

                    return archived.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
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

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string DisplaySiteName (int siteID)
        {
            using (var context = new FSOSSContext())
            {
                string siteName = (from x in context.Sites
                                            where x.site_id == siteID
                                            select x.site_name).FirstOrDefault();
                return siteName;
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
        public string UpdateSite(SitePOCO update) //currently for active sites only
        {
            using (var context = new FSOSSContext())
            {
                Regex valid = new Regex("^[a-zA-Z ]+$");
                string message = ""; 
                try
                {

                    if (valid.IsMatch(update.siteName))
                    {
                        var exists = (from x in context.Sites
                                     where x.site_id == update.siteID
                                      select x);
                        if (exists == null)
                        {
                            throw new Exception("This hospital is not open.");
                        }
                        else
                        {
                            Site updateSite = context.Sites.Find(update.siteID);
                            updateSite.site_name = update.siteName.Trim();
                            updateSite.date_modified = DateTime.Now;
                            //updateSite.administrator_account_id = admin;

                            context.Entry(updateSite).State = EntityState.Modified;
                            context.SaveChanges();
                        }

                        
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
            }//context
        }//update site

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string DisableSite(SitePOCO archive)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    // Check if the site exists
                    var searchSite = (from x in context.Sites
                                          where x.site_id == archive.siteID
                                          select new SitePOCO()
                                          {
                                              siteID = x.site_id,
                                              siteName = x.site_name,
                                              archived_yn = x.archived_yn,
                                              date_modified = DateTime.Now

                                          }).FirstOrDefault();

                        Site site = context.Sites.Find(archive.siteID);
                        if (site.archived_yn == false)
                        {
                            site.archived_yn = true;
                            site.date_modified = DateTime.Now;
                        }
                        else
                        {
                            site.archived_yn = false;
                            site.date_modified = DateTime.Now;
                        };
                        context.Entry(site).State = EntityState.Modified;
                        context.SaveChanges();

                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
                }
                return message;
            }
        }
    }
}
