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
using System.Data.Entity;
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
        public string AddUnit(UnitsPOCO newUnitNumber)
        {
            using (var context = new FSOSSContext())
            {
                Regex validUnit = new Regex("^[0-9]{1,3}[a-zA-Z]*$"); 
                string message = "";
                try
                {
                    var UnitList = from x in context.Units
                                   where x.unit_number.ToUpper().Equals(newUnitNumber.unitNumber.ToUpper())
                                   select new UnitsPOCO()
                                   {
                                       unitNumber= x.unit_number
                                   };

                    if (UnitList.Count() > 0)
                    {
                        message = "The Unit number \"" + newUnitNumber + "\" already exists. Please Add a new unit number .";
                    }

                  
                    else
                    {
                        Unit newUnit = new Unit();

                        newUnit.administrator_account_id = 1;
                        newUnit.unit_number = newUnitNumber.unitNumber.ToUpper();
                        newUnit.archived_yn = false;
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
                return message;
            }
        }//eom

        /// <summary>
        /// Method use to disable or enable Unit from the list that is use in a site
        /// </summary>
        /// <param Class UnitsPOCO="unitStatus"></param>
        /// <returns>return confirmation message</returns>

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
      

        public string SwitchUnitSatus(UnitsPOCO unitStatus)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    // Check if the unit exists
                    var unitInHospital = (from x in context.Units
                                          where x.unit_id == unitStatus.unitID
                                          select new UnitsPOCO()
                                          {
                                              unitID = x.unit_id,
                                              unitNumber = x.unit_number,
                                              dateModified = x.date_modified,
                                              archived_yn= x.archived_yn
                                          }).FirstOrDefault();
                    Unit unit = context.Units.Find(unitStatus.unitID);
 
                        if (unit.archived_yn == false)
                        {
                            unit.archived_yn = true;
                            unit.date_modified = DateTime.Now;
                        }
                        else if (unit.archived_yn == true)
                        {
                            unit.archived_yn = false;
                            unit.date_modified = DateTime.Now;
                    }

                        context.Entry(unit).State = EntityState.Modified;
                        context.SaveChanges();
                   
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
        /// <param name="unitID" name="string unitNumber"></param>
        /// <returns>return confirmation message</returns>

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateUnit(UnitsPOCO unitUpdate)
        {
            using (var context = new FSOSSContext())
            {
               
                Regex validUnit = new Regex("^[0-9]{1,3}[a-zA-Z]*$");
                string message = "";
                
                try
                {
                    

                    if (validUnit.IsMatch(unitUpdate.unitNumber))
                    {

                        var unitExists = (from x in context.Units
                                          where x.unit_id.Equals(unitUpdate.unitID)
                                          select x);


                        if (unitExists==null)
                        {
                            throw new Exception("This unit is not open.");
                        }


                        else
                        {
                            
                            Unit unitToUpdate = context.Units.Find(unitUpdate.unitID);
                            unitToUpdate.unit_number = unitUpdate.unitNumber;
                            unitToUpdate.date_modified = DateTime.Now;
                            context.Entry(unitToUpdate).State = EntityState.Modified;
                            
                            context.SaveChanges();
                        }
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

