using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region
using System.Data.Entity;
using FSOSS.System.Data.Entity;
using System.ComponentModel.DataAnnotations.Schema;
#endregion

namespace FSOSS.System.DAL
{
    public class FSOSSContext : DbContext
    {
        public FSOSSContext() : base("FSOSSConnectionString") { }

        public virtual DbSet<Participant> Participants { get; set; }
        public virtual DbSet<PotentialSurveyWord> PotentialSurveyWords { get; set; }
    }
}
