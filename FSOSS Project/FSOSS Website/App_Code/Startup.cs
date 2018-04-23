using Microsoft.Owin;
using Owin;

// All the imported non-auto generated namespaces and classes that are use for this page stored in a specific region for better organization
#region
// Namespaces and classes imported in order to use Hangfire Plugin.
using Hangfire;
// Namespaces and classes imported in order to use Hangfire Postgre ahydrax to enable Hangfire with PostgreSQL database.
using Hangfire.PostgreSql;
// Namespaces and classes imported in order to use FSOSS Controllers.
using FSOSS.System.BLL;
#endregion

[assembly: OwinStartupAttribute(typeof(FSOSS_Website.Startup))]
namespace FSOSS_Website
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
            // Initialize Hangfire; create connection to hangfire and postgre database and implement hangfire to create necessary tables and object required to run hangfire
            app.UseHangfireServer(new BackgroundJobServerOptions(), new PostgreSqlStorage("User ID = postgres; Password = Password1; Host = localhost; Port = 5432; Database = FSOSSDatabase; Pooling = false;"));
            // Initialize JobStorage to enable setting and saving scheduled jobs.
            JobStorage.Current = new PostgreSqlStorage("User ID = postgres; Password = Password1; Host = localhost; Port = 5432; Database = FSOSSDatabase; Pooling = false;");
            // Initialze Hangfire Dashboard to display all the information about background jobs. 
            app.UseHangfireDashboard();
            // Initialize Survey Word Controller
            SurveyWordController surveyMgr = new SurveyWordController();
            // Check if there is atleast 1 survey word assigned to the default hospital. (Misericordia)
            // If the return string is empty, force a call for GenerateSurveyWordOfTheDay method in Survey Word Controller to setup current survey word of the day to all hospitals;
            if (string.IsNullOrEmpty(surveyMgr.GetSurveyWord(1)))
            {
                surveyMgr.GenerateSurveyWordOfTheDay();
            }
        }
    }
}
