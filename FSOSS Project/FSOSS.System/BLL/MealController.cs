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
        /// Method use to get the list of meals
        /// </summary>
        /// <returns>List of meals</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<MealPOCO> GetMealList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var mealList = from x in context.Meals
                                   select new MealPOCO()
                                   {
                                       mealID = x.meal_id,
                                       mealDescription = x.meal_description
                                   };

                    return mealList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
    }
}
