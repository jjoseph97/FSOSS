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
        /// Method use to get list of genders
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
                                     where !x.archived_yn
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
        /// Method use to get the list of participant types
        /// </summary>
        /// <returns>List of participant types</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<GenderPOCO> GetArchivedGenderList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var genderList = from x in context.Genders
                                     where x.archived_yn
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



        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddGender(string genderDescriptionNew, int admin)
        {
            using (var context = new FSOSSContext())
            {

                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    if (genderDescriptionNew == "" || genderDescriptionNew == null)
                    {
                        throw new Exception("Please enter a gender.");
                    }
                    //add check for pre-use
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
                    if (genderList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The gender \"" + genderDescriptionNew.ToLower() + "\" already exists. Please enter a new gender.");
                    }
                    else if (GoneGenderList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The gender \"" + genderDescriptionNew.ToLower() + "\" already exists and is Archived. Please enter a new participant type.");
                    }

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

                    //throw new Exception("tried to delete ptid="+ participantTypeID);
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
        /// 
        /// </summary>
        /// <param name="ptDesc"></param>
        /// <param name="ptID"></param>
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
                    if (genderDescription == "" || genderDescription == null)
                    {
                        throw new Exception("Please enter a Participant Type Description");
                    }
                    //add duplicate check
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
                    if (genderList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The participant type \"" + genderDescription.ToLower() + "\" already exists. Please enter a new participant type.");
                    }
                    else if (GoneGenderList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The participant type \"" + genderDescription.ToLower() + "\" already exists and is Archived. Please enter a new participant type.");
                    }

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
