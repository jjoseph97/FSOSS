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
        
        //This method obtains a list of all the sites that are not closed.
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

        //This method obtains a list of all the sites that are closed.
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
                    throw new Exception("Something went wrong. " + e.Message);
                }

            }
        }
        
        // This method gets the siteID via site name.
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

        // This method gets the site name via a siteID.
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

        //This method adds a new site to the database.
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddSite(string newSiteName, int employee)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                Regex validWord = new Regex("^[a-zA-Z ]+$");

                try
                {
                    //Get a list of site names that are the same as the new site name.This will be to to check if it already exists in the database.
                    var siteList = from x in context.Sites
                                   where x.site_name.ToLower().Equals(newSiteName.ToLower())
                                   select new SitePOCO()
                                   {
                                       siteName = x.site_name
                                   };
                    //CHECK THE CHARACTER LIMIT
                    //If the user did not enter anything or if the new site name is null, display an error.
                    if (newSiteName == "" || newSiteName == null)
                    {
                        throw new Exception("Error: Please enter a site name. Field cannot be empty.");
                    }
                    //If the user enters in characters that are not approved by the Regex (defined by validWord), then display an error message.
                    else if (!validWord.IsMatch(newSiteName))
                    {
                        throw new Exception("Error: Please enter only alphabetical letters.");
                    }
                    //If the site already exists in the database, then display an error messsage.
                    else if (siteList.Count() > 0) 
                    {
                       throw new Exception("The site \"" + newSiteName.ToLower() + "\" already exists. Please enter a new site.");
                    }
                    //If everything checks out, then proceed to add the new site name to the database.
                    else 
                    {
                        Site newSite = new Site();
                        newSite.administrator_account_id = employee;
                        newSite.site_name = newSiteName.Trim();
                        newSite.date_modified = DateTime.Now;
                        newSite.archived_yn = false;
                        context.Sites.Add(newSite);
                        context.SaveChanges();

                    }
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                return message;
            } //end of using var context
                
        } // end of Addsite

        //This method updates the site name of a site that exists in the database.
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateSite(SitePOCO update) 
        {
            using (var context = new FSOSSContext())
            {
                Regex valid = new Regex("^[a-zA-Z ]+$");
                string message = ""; 
                try
                {
                    //If the user enters in characters that are not approved by the Regex (defined by validWord), then display an error message.
                    if (valid.IsMatch(update.siteName))
                    {
                        //Select all the information about a site, where the siteID matches the siteID passed in from the POCO.
                        var exists = (from x in context.Sites
                                     where x.site_id == update.siteID
                                      select x);
                        //If exists does not return anything, throw an exception.
                        if (exists == null)
                        {
                            throw new Exception("This site does not exist.");
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
