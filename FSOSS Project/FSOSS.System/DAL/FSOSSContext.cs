using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// All the imported non-auto generated namespaces and classes that are use for this page stored in a specific region for better organization
#region
// Namespaces and classes imported in order to use Entity Framework Entity Classes
using System.Data.Entity;
// Namespaces and classes imported in order to use FSOSS Entity Classes
using FSOSS.System.Data.Entity;
#endregion

namespace FSOSS.System.DAL
{
    // FSOSSContext Class inheriting DBContext class
    public class FSOSSContext : DbContext
    {
        // Assign connection string to FSOSSContext to get access to database tables
        public FSOSSContext() : base("FSOSSConnectionString") { }
        // Setup DbSets in order to perform CRUD functionality
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
