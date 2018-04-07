using Microsoft.Owin;
using Owin;
using Hangfire;
using Hangfire.PostgreSql;
using FSOSS.System.BLL;

[assembly: OwinStartupAttribute(typeof(FSOSS_Website.Startup))]
namespace FSOSS_Website
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
            app.UseHangfireServer(new BackgroundJobServerOptions(), new PostgreSqlStorage("User ID = postgres; Password = Password1; Host = localhost; Port = 5432; Database = FSOSSDatabase; Pooling = false;"));
            JobStorage.Current = new PostgreSqlStorage("User ID = postgres; Password = Password1; Host = localhost; Port = 5432; Database = FSOSSDatabase; Pooling = false;");
            app.UseHangfireDashboard();
            SurveyWordController sysmgr = new SurveyWordController();
            RecurringJob.AddOrUpdate("GenerateSurveyWord", () => sysmgr.GenerateSurveyWordOfTheDay(), Cron.Daily);
            if (string.IsNullOrEmpty(sysmgr.GetSurveyWord(1)))
            {
                RecurringJob.Trigger("GenerateSurveyWord");
            }
            // Check if recurring works. Take note this will occur every minute!
            //RecurringJob.AddOrUpdate(() => sysmgr.GenerateSurveyWordOfTheDay(), Cron.Minutely);
        }
    }
}
