using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region
using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
#endregion

namespace FSOSS.System.BLL
{
    [DataObject]
    public class GenderController
    {
        /// <summary>
        /// Method use to get one gender object
        /// </summary>
        /// <param name="genderID"></param>
        /// <returns>One gender object</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Gender GetGender(int genderID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    Gender gender = new Gender();
                    gender = (from x in context.Genders
                                where x.gender_id == genderID
                                select x).FirstOrDefault();

                    return gender;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }

            }
        }

        /// <summary>
        /// Method used to get list of genders
        /// </summary>
        /// <returns>List of genders</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<GenderPOCO> GetGenderList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var genderList = from x in context.Genders
                                     where !x.archived_yn && !x.gender_description.Contains("Prefer not to Answer")
                                     orderby x.gender_description ascending
                                     select new GenderPOCO()
                                       {
                                           genderID = x.gender_id,
                                           genderDescription = x.gender_description,
                                           administratorAccountId = x.administrator_account_id,
                                           username = x.AdministratorAccount.username,
                                           dateModified = x.date_modified,
                                           archivedYn = x.archived_yn
                                       };

                    return genderList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        //added March 29- Chris
        /// <summary>
        /// Method use to get the list of archived genders
        /// </summary>
        /// <returns>List of archived genders</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<GenderPOCO> GetArchivedGenderList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var genderList = from x in context.Genders
                                     where x.archived_yn && !x.gender_description.Contains("Prefer not to Answer")
                                     orderby x.gender_description ascending
                                     select new GenderPOCO()
                                              {
                                                  genderID = x.gender_id,
                                                  genderDescription = x.gender_description,
                                                  administratorAccountId = x.administrator_account_id,
                                                  username = x.AdministratorAccount.username,
                                                  dateModified = x.date_modified,
                                                  archivedYn = x.archived_yn
                                              };

                    return genderList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        /// <summary>
        /// Method used to add a new gender to the database
        /// </summary>
        /// <param name="genderDescriptionNew"></param>
        /// <param name="admin"></param>
        /// <returns>returns confirmation</returns>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddGender(string genderDescriptionNew, int admin)
        {
            using (var context = new FSOSSContext())
            {

                try
                {
                    //If the user was not logged in
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    //If the user tries to enter a null or empty string, then display an error message.
                    if (genderDescriptionNew == "" || genderDescriptionNew == null)
                    {
                        throw new Exception("Please enter a gender.");
                    }
                    //Add check for pre-use by checking if the new gender already exists in the database. If it does, then display an error message.
                    var genderList = from x in context.Genders
                                              where x.gender_description.ToLower().Equals(genderDescriptionNew.ToLower()) && !x.archived_yn
                                              select new GenderPOCO()
                                              {
                                                  genderDescription = x.gender_description
                                              };
                    var GoneGenderList = from x in context.Genders
                                                  where x.gender_description.ToLower().Equals(genderDescriptionNew.ToLower()) && x.archived_yn
                                                  select new GenderPOCO()
                                                  {
                                                      genderDescription = x.gender_description
                                                  };
                    if (genderList.Count() > 0) 
                    {
                        throw new Exception("The gender \"" + genderDescriptionNew.ToLower() + "\" already exists. Please enter a new gender.");
                    }
                    else if (GoneGenderList.Count() > 0) 
                    {
                        throw new Exception("The gender \"" + genderDescriptionNew.ToLower() + "\" already exists and is Archived. Please enter a new participant type.");
                    }
                    //Add the new Gender into the database
                    else
                    {
                        Gender gndr = new Gender();
                        gndr.gender_description = genderDescriptionNew;
                        gndr.administrator_account_id = admin;
                        gndr.date_modified = DateTime.Now;
                        gndr.archived_yn = false;
                        context.Genders.Add(gndr);
                        context.SaveChanges();
                        return "Gender " + genderDescriptionNew + " added.";
                    }

                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }


            }
        }

        /// <summary>
        /// Method used to update the archived_yn boolean to archive a gender or make it active
        /// </summary>
        /// <param name="genderID"></param>
        /// <param name="admin"></param>
        /// <returns>Returns a confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string ArchiveGender(int genderID, int admin)
        {
            string result = "";
            using (var context = new FSOSSContext())
            {
                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }

                    //If the gender is disabled, enable it; otherwise, disable the gender.
                    Gender gndr = context.Genders.Find(genderID);
                    if (gndr.archived_yn)
                    {
                        gndr.archived_yn = false;
                        result = "enabled.";
                    }
                    else
                    {

                        gndr.archived_yn = true;
                        result = "disabled";

                    }
                    gndr.administrator_account_id = admin;
                    gndr.date_modified = DateTime.Now;
                    context.Entry(gndr).Property(y => y.archived_yn).IsModified = true;
                    context.Entry(gndr).Property(y => y.administrator_account_id).IsModified = true;
                    context.Entry(gndr).Property(y => y.date_modified).IsModified = true;
                    context.SaveChanges();

                    return "Gender succesfully " + result;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

        }

        /// <summary>
        /// Updates the genderDescription.
        /// </summary>
        /// <param name="genderID"></param>
        /// <param name="genderDescription"></param>
        /// <param name="admin"></param>
        /// <returns>Returns a confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateGender(int genderID, string genderDescription, int admin)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    //If the gender description is an empty string or is null, then display an error message.
                    if (genderDescription == "" || genderDescription == null)
                    {
                        throw new Exception("Please enter a Participant Type Description");
                    }
                    //Check for duplicates
                    var genderList = from x in context.Genders
                                              where x.gender_description.ToLower().Equals(genderDescription.ToLower()) &&
                                              x.gender_id != genderID &&
                                              !x.archived_yn
                                              select new GenderPOCO()
                                              {
                                                  genderDescription = x.gender_description
                                              };


                    var GoneGenderList = from x in context.Genders
                                                  where x.gender_description.ToLower().Equals(genderDescription.ToLower()) && 
                                                  x.gender_id != genderID && x.archived_yn
                                                  select new GenderPOCO()
                                                  {
                                                      genderDescription = x.gender_description
                                                  };
                    if (genderList.Count() > 0) //If duplicates exist, return an error message.
                    {
                        throw new Exception("The participant type \"" + genderDescription.ToLower() + "\" already exists. Please enter a new participant type.");
                    }
                    else if (GoneGenderList.Count() > 0) //If duplicates exist, return an error message.
                    {
                        throw new Exception("The participant type \"" + genderDescription.ToLower() + "\" already exists and is Archived. Please enter a new  gender.");
                    }
                    //Update the gender description, date modified, and administrator account id
                    else
                    {

                        Gender gndr = context.Genders.Find(genderID);
                        gndr.gender_description = genderDescription;
                        gndr.date_modified = DateTime.Now;
                        gndr.administrator_account_id = admin;

                        context.Entry(gndr).Property(y => y.gender_description).IsModified = true;
                        context.Entry(gndr).Property(y => y.date_modified).IsModified = true;
                        context.Entry(gndr).Property(y => y.administrator_account_id).IsModified = true;

                        context.SaveChanges();

                        return "Gender successfully updated.";
                    }
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        } 
    }
}
