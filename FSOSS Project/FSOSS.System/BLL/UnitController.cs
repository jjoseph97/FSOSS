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
                    var unitList = from x in context.Units
                                   where x.site_id == site_id
                                   && x.archived_yn == false
                                   select new UnitsPOCO()
                                   {
                                       unitID = x.unit_id,
                                       unitNumber = x.unit_number
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
        /// Method use to get the list of Active units of the site slected
        /// </summary>
        /// <param int="site_id" ></param>
        /// <returns>returns confirmation from the Site</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<UnitsPOCO> GetActiveUnitList(int site_id)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    
                    var unitList = from y in context.Units
                                   where y.site_id == site_id
                                   && y.archived_yn == false
                                   && !y.unit_number.Contains("Not Applicable")
                                   orderby y.unit_number ascending
                                   select new UnitsPOCO()
                                   {
                                       unitID = y.unit_id,
                                       unitNumber = y.unit_number,
                                       siteID = y.site_id,
                                       dateModified = y.date_modified,
                                       username = y.AdministratorAccount.username
                                   };

                    return unitList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        } // end of GetActiveUnitList



        /// <summary>
        /// Method use to get the list of Archived Units of a Site
        /// </summary>
        /// <param int= siteID ></param>
        /// <returns>returns confirmation from the Site</returns>

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<UnitsPOCO> GetArchivedUnits(int siteID)
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    var archivedUnitList = from x in context.Units
                                           where x.archived_yn == true
                                           && !x.unit_number.Contains("Not Applicable")
                                           && x.site_id == siteID
                                           orderby x.unit_number ascending
                                           select new UnitsPOCO()
                                           {
                                               unitID = x.unit_id,
                                               unitNumber = x.unit_number,
                                               dateModified = x.date_modified,
                                               username = x.AdministratorAccount.username
                                           };

                    return archivedUnitList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
                }

            }
        }//end of GetArchivedUnits




        /// <summary>
        /// Method use to add new unit to the Site
        /// </summary>
        /// <param String="unitNumber" , int= admin , int= siteID ></param>
        /// <returns>returns confirmation from the Site</returns>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddUnit(string unitNumber, int admin, int siteID)
        {
            using (var context = new FSOSSContext())
            {
                Regex validUnit = new Regex("^[0-9]{1,3}[a-zA-Z/s]{1,47}|[a-zA-Z/s]{1,50}$");

                try
                {
                    if (admin == 0) //check to see if admin is logged in 
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }

                    if (unitNumber == "" || unitNumber == null) // check to see if add unit number text box is empty
                    {
                        throw new Exception("Please enter a Unit Number");
                    }

                    if (unitNumber.Length < 2 || unitNumber.Length > 50) // check to see the minimum and maximum length of inserted characters. 
                    {
                        throw new Exception("Input must be between 2 charaters to 50 chatecters long.");
                    }

                    if (!validUnit.IsMatch(unitNumber)) // check to see if the updated number is entered is consistent with the valid pattern set. 
                    {
                        throw new Exception("Invalid input pattern. Correct pattern (up to 3 digits followed by upto 47 alphabets) OR (up to 50 alphabets long only) without special characters.");
                    }


                    //check active units
                    var unitExist = from x in context.Units
                                    where x.unit_number.ToUpper() == unitNumber.ToUpper()
                                    && x.site_id == siteID
                                    && x.archived_yn == false
                                    select new UnitsPOCO()
                                    {
                                        unitNumber = x.unit_number,

                                    };
                    //check Archived units
                    var unitExistsInArchived = from x in context.Units
                                               where x.unit_number.ToUpper() == unitNumber.ToUpper()
                                               && x.site_id == siteID
                                               && x.archived_yn == true
                                               select new UnitsPOCO()
                                               {
                                                   unitNumber = x.unit_number,

                                               };

                    if (unitExist.Count() > 0) //if new unit exists in active so, return an error message
                    {
                        throw new Exception("The unit \"" + unitNumber.ToUpper() + "\" already exists. Please enter a new Unit.");
                    }

                    if (unitExistsInArchived.Count() > 0)//if new unit exists in archived so, return an error message

                    {
                        throw new Exception("The unit \"" + unitNumber.ToUpper() + "\" exists in archived. Check in archived in order to activate unit. ");
                    }

                    else
                    {
                        Unit newUnit = new Unit
                        {
                            unit_number = unitNumber.Trim(),
                            administrator_account_id = admin,
                            site_id = siteID,
                            date_modified = DateTime.Now,
                            archived_yn = false
                        };
                        context.Units.Add(newUnit);
                        context.SaveChanges();
                        return " Unit " + unitNumber + " added.";
                    }


                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }//end of AddUnit


        /// <summary>
        /// Method use to disable or enable Unit from the list that is use in a site
        /// </summary>
        /// <param int ="unitID" , int= "admin"></param>
        /// <returns>return confirmation message</returns>

        [DataObjectMethod(DataObjectMethodType.Delete, false)]


        public string SwitchUnitSatus(int unitID, int admin)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    // Check if the unit exists

                    Unit unit = context.Units.Find(unitID);

                    if (unit.archived_yn == false)
                    {
                        unit.archived_yn = true;
                        message = "disabled.";

                    }
                    else
                    {
                        unit.archived_yn = false;
                        message = "enabled";
                    }
                    unit.administrator_account_id = admin;
                    unit.date_modified = DateTime.Now;
                    context.Entry(unit).Property(y => y.archived_yn).IsModified = true;
                    context.Entry(unit).Property(y => y.administrator_account_id).IsModified = true;
                    context.Entry(unit).Property(y => y.date_modified).IsModified = true;
                    context.SaveChanges();

                    return "Unit successfully " + message;


                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
                }

            }
        } //end of SwitchUnitSatus(disbaling/enabling) unit



        /// <summary>
        /// Method use to Update unit from the list that is use in the Site
        /// </summary>
        /// <param name="int unitID" name="string unitNumber" name="admin" ></param>
        /// <returns>return confirmation message</returns>

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateUnit(int unitID, string unitNumber, int admin)
        {
            using (var context = new FSOSSContext())
            {

                Regex validUnit = new Regex("^[0-9]{1,3}[a-zA-Z/s]{1,47}|[a-zA-Z/s]{1,50}$");
                string message = "";

                try
                {
                    if (admin == 0) //check to see if admin is logged in 
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    if (unitNumber == "" || unitNumber == null) // check to see if unit number text box is empty
                    {
                        throw new Exception("Please enter a Unit Number");
                    }

                    if (unitNumber.Length < 2 || unitNumber.Length > 50) // check to see the minimum and maximum length of inserted characters. 
                    {
                        throw new Exception("Input must be between 2 charaters to 50 chatecters long.");
                    }

                    if (!validUnit.IsMatch(unitNumber))// check to see if the updated number is entered is consistent with the valid pattern set. 
                    {
                        throw new Exception("Invalid input pattern. Correct pattern (up to 3 digits followed by upto 47 alphabets) OR (up to 50 alphabets long only)without special characters.");
                    }



                    //check active units
                    var unitExist = from x in context.Units
                                    where x.unit_number.ToUpper() == unitNumber.ToUpper()
                                    && x.archived_yn == false
                                    select new UnitsPOCO()
                                    {
                                        unitNumber = x.unit_number,

                                    };
                    //check Archived units
                    var unitExistsInArchived = from x in context.Units
                                               where x.unit_number.ToUpper() == unitNumber.ToUpper()
                                               && x.archived_yn == true
                                               select new UnitsPOCO()
                                               {
                                                   unitNumber = x.unit_number,

                                               };
                    if (unitExist.Count() > 0) //if new unit exists in active so, return an error message
                    {
                        throw new Exception("The unit \"" + unitNumber.ToUpper() + "\" already exists. Please enter a new Unit.");
                    }

                    if (unitExistsInArchived.Count() > 0)//if new unit exists in archived so, return an error message

                    {
                        throw new Exception("The unit \"" + unitNumber.ToUpper() + "\" exists in archived. Check in archived in order to activate unit. ");
                    }


                    else
                    {

                        Unit unitToUpdate = context.Units.Find(unitID);
                        unitToUpdate.administrator_account_id = admin;
                        unitToUpdate.unit_number = unitNumber;
                        unitToUpdate.date_modified = DateTime.Now;
                        context.Entry(unitToUpdate).State = EntityState.Modified;

                        context.SaveChanges();
                        message = " Unit " + unitNumber + " updated.";
                    }

                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                return message;
            }
        }//end of update Unit

        /// <summary>
        /// Add a new unit with the value "Not Applicable" to a new site.
        /// </summary>
        /// <param string= newSiteName ></param>
        /// <param int= admin ></param>
        /// <returns>Returns a confirmation</returns>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string NewSite_NewUnit(string newSiteName, int admin)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";

                try
                {
                    //Grab the new site id, using the newSiteName
                    int siteId = (from x in context.Sites
                                  where x.site_name.Equals(newSiteName) &&
                                  x.archived_yn == false
                                  select x.site_id).FirstOrDefault();

                    //Add a new Unit with the unit_number "Not Applicable"
                    Unit newSite = new Unit()
                    {
                        administrator_account_id = admin,
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

