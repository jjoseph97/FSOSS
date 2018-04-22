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
        /// <summary>
        /// This method obtains a list of all the sites that are not closed.
        /// </summary>
        /// <returns>List of active sites</returns>
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
                                       siteName = x.site_name,
                                       dateModified = x.date_modified,
                                       username = x.AdministratorAccount.username,
                                       administrator_account_id = x.administrator_account_id,
                                       archived_yn = x.archived_yn

                                   };

                    return siteList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
        /// <summary>
        /// This method obtains a list of all the sites that are closed.
        /// </summary>
        /// <returns>List of archived sites</returns>
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
                                               dateModified = x.date_modified,
                                               username = x.AdministratorAccount.username,
                                               administrator_account_id = x.administrator_account_id,
                                               archived_yn = x.archived_yn
                                           };

                    return archived.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. " + e.Message);
                }

            }
        }
        
        /// <summary>
        /// This method gets the site name via a siteID.
        /// </summary>
        /// <param name="siteID"></param>
        /// <returns>Returns the site name associated with the siteID.</returns>
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
        /// <summary>
        /// This method adds a new site to the database.
        /// </summary>
        /// <param name="newSiteName"></param>
        /// <param name="admin"></param>
        /// <returns>Returns a confirmation message.</returns>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddSite(string newSiteName, int admin)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                Regex validWord = new Regex("^[a-zA-Z '.]+$");

                try
                {
                    //Checks to see if the newSiteName already exists in the database.
                    var siteList = from x in context.Sites
                                   where x.site_name.ToLower().Equals(newSiteName.ToLower())
                                   select new SitePOCO()
                                   {
                                       siteName = x.site_name
                                   };
                    //If the new site name is more than 100 characters long, then display an error message.
                    if (newSiteName.Length > 100)
                    {
                        throw new Exception("The site name can only be 100 characters long.");
                    }
                    //If the newSiteName is an empty string or if the new site name is null, display an error.
                    if (newSiteName == "" || newSiteName == null)
                    {
                        throw new Exception("Please enter a site name. Field cannot be empty.");
                    }
                    //If characters not approved by the Regex (defined by validWord) are entered, then display an error message.
                    else if (!validWord.IsMatch(newSiteName))
                    {
                        throw new Exception("Please enter only alphabetical letters.");
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
                        newSite.administrator_account_id = admin;
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
        /// <summary>
        /// This method updates the site name of a site that exists in the database.
        /// </summary>
        /// <param name="siteID"
        /// <param name="siteName"></param>
        /// <param name="admin"></param>
        /// <returns>Returns a confirmation message.</returns>
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateSite(int siteID, string siteName, int admin) 
        {
            using (var context = new FSOSSContext())
            {
                Regex valid = new Regex("^[a-zA-Z '.]+$");
                string message = ""; 
                try
                {
                    //If this new site name is an empty string or null, then display an error message.
                    if (siteName == "" || siteName == null)
                    {
                        throw new Exception("Please enter a site name. Field cannot be empty.");
                    }
                    //If the new site name is more than 100 characters long, then display an error message.
                    if (siteName.Length > 100)
                    {
                        throw new Exception("The site name can only be 100 characters long.");
                    }
                    //Check if the name already exists in the database.
                    var siteList = from x in context.Sites
                                     where x.site_name.ToLower().Equals(siteName.ToLower()) && 
                                     !x.archived_yn
                                     select new SitePOCO()
                                     {
                                         siteName = x.site_name
                                     };
                    var GoneSiteList = from x in context.Sites
                                         where x.site_name.ToLower().Equals(siteName.ToLower()) && 
                                         x.archived_yn
                                         select new SitePOCO()
                                         {
                                             siteName = x.site_name
                                         };
                    if (siteList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The site \"" + siteName.ToLower() + "\" already exists. Please enter a new site.");
                    }
                    else if (GoneSiteList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The site \"" + siteName.ToLower() + "\" already exists and is Archived. Please enter a new site.");
                    }
                    //Select all the information about a site, where the siteID matches the siteID passed in from the POCO.
                    var exists = (from x in context.Sites
                                  where x.site_id == siteID
                                  select x);
                    //If exists does not return anything, throw an exception.
                    if (exists == null)
                    {
                        throw new Exception("This site does not exist.");
                    }
                     //If characters not approved by the Regex (defined by valid) are entered, then display an error message.
                    if (!(valid.IsMatch(siteName)))
                    {
                        throw new Exception("Please enter only alphabetical letters.");
                    }
                    else
                    {
                        Site updateSite = context.Sites.Find(siteID);
                        updateSite.site_name = siteName.Trim();
                        updateSite.date_modified = DateTime.Now;
                        updateSite.administrator_account_id = admin;

                        context.Entry(updateSite).State = EntityState.Modified;
                        context.SaveChanges();
                    }

                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                return message;
            }//context
        }//update site

        /// <summary>
        /// Toggles the archived_yn boolean to indicate if the site is archived or not.
        /// </summary>
        /// <param name="siteName"></param>
        /// <param name="admin"></param>
        /// <returns>Returns a confirmation message.</returns>
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string ArchiveSite(int siteID, int admin)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    //If the admin is 0, then display an error message.
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }

                    // Check if the site exists
                    var searchSite = (from x in context.Sites
                                          where x.site_id == siteID
                                          select new SitePOCO()
                                          {
                                              siteID = x.site_id,
                                              siteName = x.site_name,
                                              archived_yn = x.archived_yn,
                                              dateModified = DateTime.Now

                                          }).FirstOrDefault();
                    //Select all the active sites
                    List<Site> lastSite = (from x in context.Sites
                                           where x.archived_yn == false
                                           select x).ToList();
                    if (searchSite == null)
                    {
                        throw new Exception("This site does not exist.");
                    }
                    
                    //If the site is archived, activate it and update the date modified. If the site is not archived, archive it and update the date modified.
                        Site site = context.Sites.Find(siteID);
                        if (site.archived_yn == false)
                        {
                            //If the admin is attempting to disable the last active site in the system, throw an error.
                            if (lastSite.Count() == 1)
                            {
                                 throw new Exception("Cannot disable site. There needs to be at least one active site.");
                            }
                            else { 
                                site.archived_yn = true;
                                site.date_modified = DateTime.Now;
                            }
                        }
                        else
                        {
                            site.archived_yn = false;
                            site.date_modified = DateTime.Now;
                        };
                        context.Entry(site).State = EntityState.Modified;
                        context.SaveChanges();
                        return "Site successfully updated.";

                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
    }
}
