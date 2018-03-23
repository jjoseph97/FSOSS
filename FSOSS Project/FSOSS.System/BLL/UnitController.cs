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
                                   & !y.archived_yn
                                   select new UnitsPOCO()
                                   {
                                       unitID = y.unit_id,
                                       unitNumber = y.unit_number,
                                       dateModified=y.date_modified,
                                       administratorAccountId=y.administrator_account_id,
                                       isArchived = y.archived_yn

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
                        message = "Successfully added the new unit: \"" + newUnit + "\"";
                    }
                }
                catch (Exception e)
                {
                    message = "Oops, something went wrong. Check " + e.Message;
                }
                
            }
        }//eom

        /// <summary>
        /// Method use to disable  Unit from the list that is use in a site
        /// </summary>
        /// <param name="unitID"></param>
        /// <returns>return confirmation message</returns>

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string DisableUnit(int unitID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    // Check if the unit exists
                    var unitInHospital = (from x in context.Units
                                          where x.unit_id == unitID
                                          select new UnitsPOCO()
                                                      {
                                                          unitID = x.unit_id,
                                                          unitNumber=x.unit_number,
                                                          dateModified=x.date_modified

                                                      }).FirstOrDefault();

                    if (unitInHospital == null)
                    {
                        Unit unit = context.Units.Find(unitID);
                        if (unit.archived_yn == false)
                        {
                            unit.archived_yn = true;
                        }
                        context.Entry(unit).Property(y => y.archived_yn).IsModified = true;
                        context.SaveChanges();
                    }
                    else
                    {
                        throw new Exception("Unable to archive selected Unit. Unit is currently active.");
                    }
                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
                }
                return message;
            }
        }

        /// <summary>
        /// Method use to Update unit from the list that is use in the Site
        /// </summary>
        /// <param name="unit_id" name,"string unit_number"></param>
        /// <returns>return confirmation message</returns>

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateUnit(int unitID, string unit_number)
        {
            using (var context = new FSOSSContext())
            {
                unit_number = unit_number.ToUpper();
                Regex validUnit = new Regex("^[0-9]{1,3}\\s{0,1}[a-zA-Z]*$");
                string message = "";
                bool inUse = false;
                try
                {
                    var unitList = (from x in context.Units
                                          select new UnitsPOCO()
                                          {
                                              unitID = x.unit_id,
                                              dateModified = x.date_modified,
                                              unitNumber = x.unit_number
                                          }).ToList();


                    foreach (UnitsPOCO item in unitList)
                    {
                        if (item.unitID == unitID && item.dateModified == DateTime.Now)
                        {
                            inUse = true;
                            break;
                        }
                    }

                    if (validUnit.IsMatch(unit_number) && inUse == false)
                    {
                        var unitToUpdate = context.Units.Find(unitID);
                        unitToUpdate.archived_yn = true;
                        unitToUpdate.date_modified = DateTime.Now;
                        context.Entry(unitToUpdate).Property(y => y.archived_yn).IsModified = true;
                        context.Entry(unitToUpdate).Property(y => y.date_modified).IsModified = true;
                        context.SaveChanges();
                    }
                    else
                    {
                        throw new Exception("Unit is currently use. Update failed.");
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

