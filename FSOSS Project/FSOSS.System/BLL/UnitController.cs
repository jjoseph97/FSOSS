using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region
using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using System.Text.RegularExpressions;
#endregion
namespace FSOSS.System.BLL
{
    [DataObject]
    public class UnitController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<UnitsPOCO> GetUnitList(int site_id)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var unitList = from x in context.Sites
                                   from y in context.Units
                                   where x.site_id == y.site_id
                                   & !y.is_closed_yn
                                   select new UnitsPOCO()
                                   {
                                       unitID = y.unit_id,
                                       unitNumber = y.unit_number
                                   };

                    return unitList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        /// <summary>
        /// Method use to add new unit to the Site
        /// </summary>
        /// <param name="unit_number"></param>
        /// <returns>returns confirmation from the Site</returns>

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void AddUnit(string unit_number)
        {
            using (var context = new FSOSSContext())
            {
                unit_number = unit_number.ToUpper();
                string message = "";
                try
                {
                    var UnitList = from x in context.Units
                                                  where x.unit_number.ToUpper().Equals(unit_number.ToUpper())
                                                  select new UnitsPOCO()
                                                  {
                                                      unitNumber = x.unit_number
                                                  };

                    if (UnitList.Count() > 0)
                    {
                        message = "The Unit number \"" + unit_number.ToUpper() + "\" already exists. Please Add a new unit number .";
                    }

                    else
                    {
                        Unit newUnit = new Unit();
                        // to be set once the admin security is working
                        newUnit.administrator_account_id = 1;
                        newUnit.unit_number = unit_number;
                        newUnit.date_modified = DateTime.Now;
                        context.Units.Add(newUnit);
                        context.SaveChanges();
                        message = "Successfully added the new survey word: \"" + newUnit + "\"";
                    }
                }
                catch (Exception e)
                {
                    message = "Oops, something went wrong. Check " + e.Message;
                }
                
            }
        }//eom

   

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public void DeleteUnit(int unit_id)
        {
            using (var context = new FSOSSContext())
            {
                var existingUnit_ID = context.Units.Find(unit_id);
                context.Units.Remove(existingUnit_ID);
                context.SaveChanges();

            }
        }//eom

    }
}

