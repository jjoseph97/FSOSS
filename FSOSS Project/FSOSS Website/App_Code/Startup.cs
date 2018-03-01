using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(FSOSS_Website.Startup))]
namespace FSOSS_Website
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
