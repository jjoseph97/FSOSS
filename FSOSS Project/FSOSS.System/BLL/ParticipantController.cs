using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region
using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
#endregion

namespace FSOSS.System.BLL
{
    [DataObject]
    public class ParticipantController
    {
        //Read Data
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Participant GetParticipant(int participantID)
        {
            // transaction start
            using (var context = new FSOSSContext())
            {
                Participant participant = new Participant();
                participant = (from x in context.Participants
                               where x.participant_type_id == participantID
                               select x).FirstOrDefault();

                return participant;
            }
        }

        //Add Data
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddParticipant(string participantDescription)
        {
            // transaction start
            using (var context = new FSOSSContext())
            {
                try
                {
                    Participant participant = new Participant();
                    participant.participant_description = participantDescription;
                    context.Participants.Add(participant);
                    context.SaveChanges();
                    return "Add Success";
                }
                catch (Exception e)
                {
                    return "Add Fail " + e.Message;
                }



            }
        }

        //Add Data
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateParticipant(int participantID, string participantDescription)
        {
            // transaction start
            using (var context = new FSOSSContext())
            {
                try
                {
                    Participant participant = new Participant();
                    participant = (from x in context.Participants
                                   where x.participant_type_id == participantID
                                   select x).FirstOrDefault();
                    participant.participant_description = participantDescription;
                    context.SaveChanges();
                    return "Update Success";
                }
                catch (Exception e)
                {
                    return "Update Fail " + e.Message;
                }
            }
        }

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string DeleteParticipant(int participantID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var existing = context.Participants.Find(participantID);
                    context.Participants.Remove(existing);
                    context.SaveChanges();
                    return "Delete Success";
                }
                catch (Exception e)
                {
                    return "Delete Fail " + e.Message;
                }

            }
        }


    }
}