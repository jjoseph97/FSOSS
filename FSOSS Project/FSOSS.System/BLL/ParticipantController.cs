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
        /// <summary>
        /// Method use to get one participant type object
        /// </summary>
        /// <param name="participantID"></param>
        /// <returns>One participant object</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public ParticipantType GetParticipant(int participantID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    ParticipantType participant = new ParticipantType();
                    participant = (from x in context.ParticipantTypes
                                   where x.participant_type_id == participantID
                                   select x).FirstOrDefault();

                    return participant;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }

            }
        }

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
                                                  ,archivedYn=x.archived_yn
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
        public void AddParticipantType(ParticipantTypePOCO pt)
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    //add check for pre-use



                     ParticipantType pt2 = new ParticipantType();
                     pt2.participant_description = pt.participantTypeDescription;
                    pt2.administrator_account_id = 1;
                    pt2.date_modified = DateTime.Now;
                    pt2.archived_yn = false;
                    context.ParticipantTypes.Add(pt2);
                    context.SaveChanges();

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
        public void ArchiveParticipantType(ParticipantTypePOCO pt)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    //throw new Exception("tried to delete ptid="+ participantTypeID);
                    ParticipantType pt2 = context.ParticipantTypes.Find(pt.participantTypeID);
                    if (pt2.archived_yn)
                    {
                        pt2.archived_yn = false;
                    }
                    else
                    {

                        pt2.archived_yn = true;
                    }
                    context.Entry(pt2).Property(y => y.archived_yn).IsModified = true;
                    context.SaveChanges();
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
        public void UpdateParticipantType(ParticipantTypePOCO pt)
        {
            using (var context = new FSOSSContext())
            {
                try
                {

                    //add duplicate check

                    ParticipantType pt2 = context.ParticipantTypes.Find(pt.participantTypeID);
                    pt2.participant_description = pt.participantTypeDescription;
                    pt2.date_modified = DateTime.Now;
                    //add adminid

                    context.Entry(pt2).Property(y => y.participant_description).IsModified = true;
                    context.Entry(pt2).Property(y => y.date_modified).IsModified = true;

                    context.SaveChanges();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }


    }
}