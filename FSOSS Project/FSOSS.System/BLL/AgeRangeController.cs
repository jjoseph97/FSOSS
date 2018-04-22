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
    public class AgeRangeController
    {
        /// <summary>
        /// Method use to get one age range object
        /// </summary>
        /// <param name="ageID"></param>
        /// <returns>One age range object</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public AgeRange GetTopicAge(int ageID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    AgeRange ageRange = new AgeRange();
                    ageRange = (from x in context.AgeRanges
                                where x.age_range_id == ageID
                                select x).FirstOrDefault();

                    return ageRange;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }

            }
        }

        /// <summary>
        /// updated april 8- chris
        /// Method use to get list of active age ranges
        /// </summary>
        /// <returns>List of active age ranges</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<AgeRangePOCO> GetAgeRangeList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var ageRangeList = from x in context.AgeRanges
                                       where !x.archived_yn && !x.age_range_description.Contains("Prefer not to answer")
                                       orderby x.age_range_description ascending
                                       select new AgeRangePOCO()
                                   {
                                       ageRangeID = x.age_range_id,
                                       ageRangeDescription = x.age_range_description,
                                       administratorAccountId = x.administrator_account_id,
                                       username = x.AdministratorAccount.username,
                                       dateModified = x.date_modified,
                                       archivedYn = x.archived_yn
                                   };

                    return ageRangeList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }


        //added APril 8- Chris
        /// <summary>
        /// Method use to get the list of archived age ranges
        /// </summary>
        /// <returns>List of archived meals</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<AgeRangePOCO> GetArchivedAgeRangeList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var ageList = from x in context.AgeRanges
                                   where x.archived_yn && !x.age_range_description.Contains("Prefer not to answer")
                                  orderby x.age_range_description ascending
                                  select new AgeRangePOCO()
                                   {
                                       ageRangeID = x.age_range_id,
                                       ageRangeDescription = x.age_range_description
                                       ,
                                       administratorAccountId = x.administrator_account_id,
                                       username = x.AdministratorAccount.username,
                                       dateModified = x.date_modified,
                                       archivedYn = x.archived_yn
                                   };

                    return ageList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }




        //added April 8, 2018- Chris
        /// <summary>
        /// Adds new age range for use in the Survey
        /// </summary>
        /// <param name="ageRangeDescription">The new age range description</param>
        /// <param name="admin"> The ID of the Administrator Account that created the newage range</param>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddAgeRange(string ageRangeDescription, int admin)
        {
            using (var context = new FSOSSContext())
            {

                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    if (ageRangeDescription == "" || ageRangeDescription == null)
                    {
                        throw new Exception("Please enter an Age Range Description");
                    }
                    //add check for pre-use
                    var ageList = from x in context.AgeRanges
                                   where x.age_range_description.ToLower().Equals(ageRangeDescription.ToLower()) && !x.archived_yn
                                   select new AgeRangePOCO()
                                   {
                                       ageRangeDescription = x.age_range_description
                                   };


                    var GoneageList = from x in context.AgeRanges
                                       where x.age_range_description.ToLower().Equals(ageRangeDescription.ToLower()) && x.archived_yn
                                       select new AgeRangePOCO()
                                       {
                                           ageRangeDescription = x.age_range_description
                                       };
                    if (ageList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The age range \"" + ageRangeDescription.ToLower() + "\" already exists. Please enter a new age range.");
                    }
                    else if (GoneageList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The age range \"" + ageRangeDescription.ToLower() + "\" already exists and is Archived. Please enter a new age range.");
                    }

                    else
                    {
                        AgeRange age = new AgeRange();
                        age.age_range_description = ageRangeDescription;
                        age.administrator_account_id = admin;
                        age.date_modified = DateTime.Now;
                        age.archived_yn = false;
                        context.AgeRanges.Add(age);
                        context.SaveChanges();
                        return "Age Range " + ageRangeDescription + " added.";
                    }

                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }


            }
        }

        /// <summary>
        /// Added april 8- chris
        /// Toggle whether or not an age range is Archived (useable on the Survey)
        /// </summary>
        /// <param name="ageRangeID">The ID of the Age Range to (un)archive</param>
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string ArchiveAgeRange(int ageRangeID, int admin)
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

                    AgeRange age = context.AgeRanges.Find(ageRangeID);
                    if (age.archived_yn)
                    {
                        age.archived_yn = false;
                        result = "enabled.";
                    }
                    else
                    {

                        age.archived_yn = true;
                        result = "disabled";

                    }
                    age.administrator_account_id = admin;
                    age.date_modified = DateTime.Now;
                    context.Entry(age).Property(y => y.archived_yn).IsModified = true;
                    context.Entry(age).Property(y => y.administrator_account_id).IsModified = true;
                    context.Entry(age).Property(y => y.date_modified).IsModified = true;
                    context.SaveChanges();

                    return "Age Range succesfully " + result;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

        }

        /// <summary>
        /// change the age range description of an age range
        /// </summary>
        /// <param name="ageRangeID">The ID of the age range who's age range description is changing</param>
        /// <param name="ageRangeDescription">The new age range description</param>
        /// <param name="admin">The ID of the Administrator Account logged in  at the moment of age range update</param>
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateAgeRange(int ageRangeID, string ageRangeDescription, int admin)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    if (ageRangeDescription == "" || ageRangeDescription == null)
                    {
                        throw new Exception("Please enter an age range description");
                    }
                    //add duplicate check
                    var ageList = from x in context.AgeRanges
                                   where x.age_range_description.ToLower().Equals(ageRangeDescription.ToLower()) &&
                                   x.age_range_id != ageRangeID && !x.archived_yn
                                   select new AgeRangePOCO()
                                   {
                                       ageRangeDescription = x.age_range_description
                                   };


                    var GoneageList = from x in context.AgeRanges
                                       where x.age_range_description.ToLower().Equals(ageRangeDescription.ToLower()) &&
                                       x.age_range_id != ageRangeID && x.archived_yn
                                       select new AgeRangePOCO()
                                       {
                                           ageRangeDescription = x.age_range_description
                                       };
                    if (ageList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The age range \"" + ageRangeDescription.ToLower() + "\" already exists. Please enter a new age range.");
                    }
                    else if (GoneageList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The age range \"" + ageRangeDescription.ToLower() + "\" already exists and is Archived. Please enter a new age range.");
                    }

                    else
                    {

                        AgeRange age = context.AgeRanges.Find(ageRangeID);
                        age.age_range_description = ageRangeDescription;
                        age.date_modified = DateTime.Now;
                        age.administrator_account_id = admin;

                        context.Entry(age).Property(y => y.age_range_description).IsModified = true;
                        context.Entry(age).Property(y => y.date_modified).IsModified = true;
                        context.Entry(age).Property(y => y.administrator_account_id).IsModified = true;

                        context.SaveChanges();

                        return "Age Range successfully updated.";
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
