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
                                   && y.archived_yn == false
                                   select new UnitsPOCO()
                                   {
                                       unitID = y.unit_id,
                                       unitNumber = y.unit_number,
                                       dateModified = y.date_modified,


                                   };

                    return unitList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        #region GetList(Proper?)
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<UnitsPOCO> GetUnitListModified(int site_id)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var unitList = from y in context.Units
                                   where y.site_id == site_id
                                   && y.archived_yn == false
                                   select new UnitsPOCO()
                                   {
                                       unitID = y.unit_id,
                                       unitNumber = y.unit_number,
                                       dateModified = y.date_modified,


                                   };

                    return unitList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
        #endregion


        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<UnitsPOCO> GetArchivedUnits(int unitID)
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    var archivedUnitList = from x in context.Units
                                           where x.archived_yn == true
                                           select new UnitsPOCO()
                                           {
                                               unitID = x.unit_id,
                                               unitNumber = x.unit_number,
                                               dateModified = x.date_modified
                                           };

                    return archivedUnitList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
                }

            }
        }




        /// <summary>
        /// Method use to add new unit to the Site
        /// </summary>
        /// <param Entity="Unit"></param>
        /// <returns>returns confirmation from the Site</returns>

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void AddUnit(Unit newunitNumber, string unitNumber)
        {
            using (var context = new FSOSSContext())
            {

                string message = "";
                try
                {
                    var UnitList = from x in context.Units
                                   where x.unit_number.ToUpper().Equals(unitNumber)
                                   select new Unit()
                                   {
                                       unit_number = x.unit_number
                                   };

                    if (UnitList.Count() > 0)
                    {
                        message = "The Unit number \"" + unitNumber + "\" already exists. Please Add a new unit number .";
                    }

                    else
                    {
                        Unit newUnit = new Unit();
                        // to be set once the admin security is working
                        newUnit.administrator_account_id = 1;
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
        /// Method use to disable or enable Unit from the list that is use in a site
        /// </summary>
        /// <param Entity="Unit"></param>
        /// <returns>return confirmation message</returns>

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public void SwitchUnitSatus(Unit unit)
        {
            SwitchUnitSatus(unit.unit_id);
        }

        public string SwitchUnitSatus(int unitID)
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
                                              unitNumber = x.unit_number,
                                              dateModified = x.date_modified

                                          }).FirstOrDefault();

                    if (unitInHospital != null)
                    {
                        Unit unit = context.Units.Find(unitID);
                        if (unit.archived_yn == false)
                        {
                            unit.archived_yn = true;
                        }
                        else if (unit.archived_yn == true)
                        {
                            unit.archived_yn = false;
                        }

                        context.Entry(unit).Property(y => y.archived_yn).IsModified = true;
                        context.SaveChanges();
                    }
                    else
                    {
                        throw new Exception("Unable to archive selected Unit.");
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
        /// <param name="unit_id" name="string unitNumber"></param>
        /// <returns>return confirmation message</returns>

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateUnit(int unitID, string unitNumber, DateTime dateModified)
        {
            using (var context = new FSOSSContext())
            {
                unitNumber = unitNumber.ToUpper();
                Regex validUnit = new Regex("^[0-9]{1,3}[a-zA-Z]*$");
                string message = "";
                bool inUse = false;
                try
                {
                    var unitList = (from x in context.Units
                                    select new UnitsPOCO()
                                    {
                                        unitID = x.unit_id,
                                        unitNumber = x.unit_number,
                                        dateModified = x.date_modified
                                    }).ToList();


                    foreach (UnitsPOCO item in unitList)
                    {
                        if (item.unitID == unitID && item.dateModified == DateTime.Now)
                        {
                            inUse = true;
                            break;
                        }
                    }

                    if (validUnit.IsMatch(unitNumber) && inUse == false)
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

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string NewSite_NewUnit (string newSiteName, int employee) 
            // add Not Applicable Unit to the new site.
        {
            using (var context = new FSOSSContext())
            {
                string message = "";

                try
                {
                    //grab the new site id,
                    int siteId = (from x in context.Sites
                                  where x.site_name.Equals(newSiteName) && 
                                  x.archived_yn == false
                                  select x.site_id).FirstOrDefault();

                    //add the new unit where unit number is NA
                    Unit newSite = new Unit()
                    {
                        administrator_account_id = employee,
                        site_id = siteId,
                        date_modified = DateTime.Now,
                        unit_number = "Not Applicable",
                        archived_yn = false
                    };
                    context.Units.Add(newSite);
                    context.SaveChanges();

                }
                catch (Exception e)
                {
                    message = "Oops, something went wrong. Check " + e.Message;
                }
                return message;
            } //end of using var context

        } // end of Addsite
    }
}

