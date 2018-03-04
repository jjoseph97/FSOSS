using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
#region
using FSOSS.System.BLL;
using FSOSS.System.Data;
using FSOSS.System.Data.Entity;
#endregion

public partial class Pages_ParticpantSampleCRUD : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        ParticipantController sysmgr = new ParticipantController();
        int participantID = int.Parse(ParticipantTypeIDTextBox.Text);
        ParticipantType participant = new ParticipantType();
        participant = sysmgr.GetParticipant(participantID);
        ParticipantTypeDescriptionTextBox.Text = participant.participant_description;
        UpdateParticipantIDLabel.Text = participant.participant_type_id.ToString();
    }

    protected void AddButton_Click(object sender, EventArgs e)
    {
        ParticipantController sysmgr = new ParticipantController();
        ParticipantType participant = new ParticipantType();
        Status.Text = sysmgr.AddParticipant(AddParticipantTypeDescriptionTextBox.Text);
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        ParticipantController sysmgr = new ParticipantController();
        int participantID = int.Parse(UpdateParticipantIDLabel.Text);
        UpdateStatus.Text = sysmgr.UpdateParticipant(participantID, UpdateDescription.Text);
    }

    protected void Delete_Click(object sender, EventArgs e)
    {
        ParticipantController sysmgr = new ParticipantController();
        DeleteStatus.Text = sysmgr.DeleteParticipant(int.Parse(DeleteParticipantID.Text));
    }
}