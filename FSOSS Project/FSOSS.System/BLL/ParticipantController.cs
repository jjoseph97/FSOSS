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
                                              select new ParticipantTypePOCO()
                                              {
                                                  participantTypeID = x.participant_type_id,
                                                  participantTypeDescription = x.participant_description
                                              };

                    return participantTypeList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
    }
}