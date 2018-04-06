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
    public class ParticipantController
    {
        //COmmented out April 6th. If nothing bad occurs of this, remove outright.
        /// <summary>
        /// Method use to get one participant type object. 
        /// </summary>
        /// <param name="participantID"></param>
        /// <returns>One participant object</returns>
        //[DataObjectMethod(DataObjectMethodType.Select, false)]
        //public ParticipantType GetParticipant(int participantID)
        //{

        //    using (var context = new FSOSSContext())
        //    {
        //        try
        //        {
        //            ParticipantType participant = new ParticipantType();
        //            participant = (from x in context.ParticipantTypes
        //                           where x.participant_type_id == participantID
        //                           select x).FirstOrDefault();

        //            return participant;
        //        }
        //        catch (Exception e)
        //        {
        //            throw new Exception(e.Message);
        //        }

        //    }
        //}

        /// <summary>
        /// Method use to get the list of participant types
        /// </summary>
        /// <returns>List of participant types</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ParticipantTypePOCO> GetParticipantTypeList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var participantTypeList = from x in context.ParticipantTypes
                                              where !x.archived_yn
                                              select new ParticipantTypePOCO()
                                              {
                                                  participantTypeID = x.participant_type_id,
                                                  participantTypeDescription = x.participant_description
                                                  ,
                                                  administratorAccountId = x.administrator_account_id,
                                                  username = x.AdministratorAccount.username,
                                                  dateModified = x.date_modified,
                                                  archivedYn = x.archived_yn
                                              };

                    return participantTypeList.ToList();
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
        public List<ParticipantTypePOCO> GetArchivedParticipantTypeList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var participantTypeList = from x in context.ParticipantTypes
                                              where x.archived_yn
                                              select new ParticipantTypePOCO()
                                              {
                                                  participantTypeID = x.participant_type_id,
                                                  participantTypeDescription = x.participant_description
                                                  ,
                                                  administratorAccountId = x.administrator_account_id,
                                                  username = x.AdministratorAccount.username,
                                                  dateModified = x.date_modified,
                                                  archivedYn = x.archived_yn
                                              };

                    return participantTypeList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }




        //added March 27, 2018- Chris
        /// <summary>
        /// Adds new Participant Types for use in the Survey
        /// </summary>
        /// <param name="ptDesc">The new Participant Type Description</param>
        /// <param name="adminID"> The ID of the Administrator Account that created the new Participant Type</param>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddParticipantType(string participantTypeDescription, int admin)
        {
            using (var context = new FSOSSContext())
            {

                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    if (participantTypeDescription=="" || participantTypeDescription==null)
                    {
                        throw new Exception("Please enter a Participant Type Description");
                    }
                    //add check for pre-use
                    var participantTypeList = from x in context.ParticipantTypes
                                              where x.participant_description.ToLower().Equals(participantTypeDescription.ToLower()) && !x.archived_yn
                                              select new ParticipantTypePOCO()
                                              {
                                                  participantTypeDescription = x.participant_description
                                              };


                    var GoneparticipantTypeList = from x in context.ParticipantTypes
                                                  where x.participant_description.ToLower().Equals(participantTypeDescription.ToLower()) && x.archived_yn
                                                  select new ParticipantTypePOCO()
                                                  {
                                                      participantTypeDescription = x.participant_description
                                                  };
                    if (participantTypeList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The participant type \"" + participantTypeDescription.ToLower() + "\" already exists. Please enter a new participant type.");
                    }
                    else if (GoneparticipantTypeList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The participant type \"" + participantTypeDescription.ToLower() + "\" already exists and is Archived. Please enter a new participant type.");
                    }

                    else
                    {
                        ParticipantType pt2 = new ParticipantType();
                        pt2.participant_description = participantTypeDescription;
                        pt2.administrator_account_id = admin;
                        pt2.date_modified = DateTime.Now;
                        pt2.archived_yn = false;
                        context.ParticipantTypes.Add(pt2);
                        context.SaveChanges();
                        return "Participant Type " + participantTypeDescription + " added.";
                    }

                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }


            }
        }

        /// <summary>
        /// Toggle whether or not a Participant Type is Archived (useable on the Survey)
        /// </summary>
        /// <param name="ptID">The ID of the Participant Type to (un)archive</param>
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string ArchiveParticipantType(int participantTypeID, int admin)
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
                    ParticipantType pt2 = context.ParticipantTypes.Find(participantTypeID);
                    if (pt2.archived_yn)
                    {
                        pt2.archived_yn = false;
                        result = "enabled.";
                    }
                    else
                    {

                        pt2.archived_yn = true;
                        result = "disabled";

                    }
                    pt2.administrator_account_id = admin;
                    pt2.date_modified = DateTime.Now;
                    context.Entry(pt2).Property(y => y.archived_yn).IsModified = true;
                    context.Entry(pt2).Property(y => y.administrator_account_id).IsModified = true;
                    context.Entry(pt2).Property(y => y.date_modified).IsModified = true;
                    context.SaveChanges();

                    return "Participant Type succesfully " + result;
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
        public string UpdateParticipantType(int participantTypeID, string participantTypeDescription, int admin)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    if (admin == 0)
                    {
                        throw new Exception("Can't let you do that. You're not logged in.");
                    }
                    if (participantTypeDescription == "" || participantTypeDescription == null)
                    {
                        throw new Exception("Please enter a Participant Type Description");
                    }
                    //add duplicate check
                    var participantTypeList = from x in context.ParticipantTypes
                                              where x.participant_description.ToLower().Equals(participantTypeDescription.ToLower()) && !x.archived_yn
                                              select new ParticipantTypePOCO()
                                              {
                                                  participantTypeDescription = x.participant_description
                                              };


                    var GoneparticipantTypeList = from x in context.ParticipantTypes
                                                  where x.participant_description.ToLower().Equals(participantTypeDescription.ToLower()) && x.archived_yn
                                                  select new ParticipantTypePOCO()
                                                  {
                                                      participantTypeDescription = x.participant_description
                                                  };
                    if (participantTypeList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The participant type \"" + participantTypeDescription.ToLower() + "\" already exists. Please enter a new participant type.");
                    }
                    else if (GoneparticipantTypeList.Count() > 0) //if so, return an error message
                    {
                        throw new Exception("The participant type \"" + participantTypeDescription.ToLower() + "\" already exists and is Archived. Please enter a new participant type.");
                    }

                    else
                    {

                        ParticipantType pt2 = context.ParticipantTypes.Find(participantTypeID);
                        pt2.participant_description = participantTypeDescription;
                        pt2.date_modified = DateTime.Now;
                        pt2.administrator_account_id = admin;

                        context.Entry(pt2).Property(y => y.participant_description).IsModified = true;
                        context.Entry(pt2).Property(y => y.date_modified).IsModified = true;
                        context.Entry(pt2).Property(y => y.administrator_account_id).IsModified = true;

                        context.SaveChanges();

                        return "Participant Type successfully updated.";
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