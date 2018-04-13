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
    public class MealController
    {
        /// <summary>
        /// Method use to get one meal object
        /// </summary>
        /// <param name="mealID"></param>
        /// <returns>One meal object</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Meal GetMeal(int mealID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    Meal meal = new Meal();
                    meal = (from x in context.Meals
                            where x.meal_id == mealID
                            select x).FirstOrDefault();

                    return meal;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }

            }
        }

        /// <summary>
        /// Update April 8- Chris
        /// Method use to get the list of active meals
        /// </summary>
        /// <returns>List of active meals</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<MealPOCO> GetMealList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var mealList = from x in context.Meals
                                   where !x.archived_yn
                                   orderby x.meal_name ascending
                                   select new MealPOCO()
                                   {
                                       mealID = x.meal_id,
                                       mealName = x.meal_name,
                                       administratorAccountId = x.administrator_account_id,
                                       username = x.AdministratorAccount.username,
                                       dateModified = x.date_modified,
                                       archivedYn = x.archived_yn
                                   };

                    return mealList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }



        
        //added APril 8- Chris
        /// <summary>
        /// Method use to get the list of archived meals
        /// </summary>
        /// <returns>List of archived meals</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<MealPOCO> GetArchivedMealList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var mealList = from x in context.Meals
                                              where x.archived_yn
                                              orderby x.meal_name ascending
                                   select new MealPOCO()
                                              {
                                                  mealID = x.meal_id,
                                                  mealName = x.meal_name
                                                  ,
                                                  administratorAccountId = x.administrator_account_id,
                                                  username = x.AdministratorAccount.username,
                                                  dateModified = x.date_modified,
                                                  archivedYn = x.archived_yn
                                              };

                    return mealList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }




        //added April 8, 2018- Chris
        /// <summary>
        /// Adds new Meal for use in the Survey
        /// </summary>
        /// <param name="mealName">The new meal name</param>
        /// <param name="adminID"> The ID of the Administrator Account that created the new meal name</param>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddMeal(string mealName, int admin)
        {
            using (var context = new FSOSSContext())
            {

                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    if (mealName == "" || mealName == null)
                    {
                        throw new Exception("Please enter a Meal Name");
                    }
                    //add check for pre-use
                    var mealList = from x in context.Meals
                                              where x.meal_name.ToLower().Equals(mealName.ToLower()) && !x.archived_yn
                                              select new MealPOCO()
                                              {
                                                   mealName = x.meal_name
                                              };


                    var GonemealList = from x in context.Meals
                                                  where x.meal_name.ToLower().Equals(mealName.ToLower()) && x.archived_yn
                                                  select new MealPOCO()
                                                  {
                                                      mealName = x.meal_name
                                                  };
                    if (mealList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The participant type \"" + mealName.ToLower() + "\" already exists. Please enter a new meal.");
                    }
                    else if (GonemealList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The participant type \"" + mealName.ToLower() + "\" already exists and is Archived. Please enter a new meal.");
                    }

                    else
                    {
                        Meal meal = new Meal();
                        meal.meal_name = mealName;
                        meal.administrator_account_id = admin;
                        meal.date_modified = DateTime.Now;
                        meal.archived_yn = false;
                        context.Meals.Add(meal);
                        context.SaveChanges();
                        return "Meal " + mealName + " added.";
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
        /// Toggle whether or not a Meal is Archived (useable on the Survey)
        /// </summary>
        /// <param name="mealID">The ID of the Meal to (un)archive</param>
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string ArchiveMeal(int mealID, int admin)
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
                    
                    Meal meal = context.Meals.Find(mealID);
                    if (meal.archived_yn)
                    {
                        meal.archived_yn = false;
                        result = "enabled.";
                    }
                    else
                    {

                        meal.archived_yn = true;
                        result = "disabled";

                    }
                    meal.administrator_account_id = admin;
                    meal.date_modified = DateTime.Now;
                    context.Entry(meal).Property(y => y.archived_yn).IsModified = true;
                    context.Entry(meal).Property(y => y.administrator_account_id).IsModified = true;
                    context.Entry(meal).Property(y => y.date_modified).IsModified = true;
                    context.SaveChanges();

                    return "Meal succesfully " + result;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }

        }

        /// <summary>
        /// change the Meal name of a Meal
        /// </summary>
        /// <param name="mealID">The ID of the meal whose meal name is changing</param>
        /// <param name="mealName">The new Meal Name</param>
        /// <param name="admin">The ID of the Administrator Account logged in  at the moment of meal update</param>
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateParticipantType(int mealID, string mealName, int admin)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    if (mealName == "" || mealName == null)
                    {
                        throw new Exception("Please enter a Meal Name");
                    }
                    //add duplicate check
                    var mealList = from x in context.Meals
                                              where x.meal_name.ToLower().Equals(mealName.ToLower()) &&
                                              x.meal_id != mealID && !x.archived_yn
                                              select new MealPOCO()
                                              {
                                                  mealName = x.meal_name
                                              };


                    var GoneMealList = from x in context.Meals
                                                  where x.meal_name.ToLower().Equals(mealName.ToLower()) &&
                                                  x.meal_id != mealID && x.archived_yn
                                                  select new MealPOCO()
                                                  {
                                                      mealName = x.meal_name
                                                  };
                    if (mealList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The meal \"" + mealName.ToLower() + "\" already exists. Please enter a new meal.");
                    }
                    else if (GoneMealList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The meal \"" + mealName.ToLower() + "\" already exists and is Archived. Please enter a new meal.");
                    }

                    else
                    {

                        Meal meal = context.Meals.Find(mealID);
                        meal.meal_name = mealName;
                        meal.date_modified = DateTime.Now;
                        meal.administrator_account_id = admin;

                        context.Entry(meal).Property(y => y.meal_name).IsModified = true;
                        context.Entry(meal).Property(y => y.date_modified).IsModified = true;
                        context.Entry(meal).Property(y => y.administrator_account_id).IsModified = true;

                        context.SaveChanges();

                        return "Meal successfully updated.";
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
