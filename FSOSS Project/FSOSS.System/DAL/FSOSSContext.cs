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
        // Latest Update March 4, 2018. Ren
        public virtual DbSet<ParticipantType> ParticipantTypes { get; set; }
        public virtual DbSet<PotentialSurveyWord> PotentialSurveyWords { get; set; }
        public virtual DbSet<AdministratorAccount> AdministratorAccounts { get; set; }
        public virtual DbSet<AdministratorRole> AdministratorRoles { get; set; }
        public virtual DbSet<AgeRange> AgeRanges { get; set; }
        public virtual DbSet<Gender> Genders { get; set; }
        public virtual DbSet<Meal> Meals { get; set; }
        public virtual DbSet<ParticipantResponse> ParticipantResponses { get; set; }
        public virtual DbSet<Question> Questions { get; set; }
        public virtual DbSet<QuestionFormat> QuestionFormats { get; set; }
        public virtual DbSet<QuestionSelection> QuestionSelections { get; set; }
        public virtual DbSet<QuestionTopic> QuestionTopics { get; set; }
        public virtual DbSet<SecurityRole> SecurityRoles { get; set; }
        public virtual DbSet<Site> Sites { get; set; }
        public virtual DbSet<SubmittedSurvey> SubmittedSurveys { get; set; }
        public virtual DbSet<SurveyQuestion> SurveyQuestions { get; set; }
        public virtual DbSet<SurveyVersion> SurveyVersions { get; set; }
        public virtual DbSet<SurveyWord> SurveyWords { get; set; }
        public virtual DbSet<Unit> Units { get; set; }
    }
}
