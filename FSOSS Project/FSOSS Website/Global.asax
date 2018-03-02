<%@ Application Language="C#" %>
<%@ Import Namespace="FSOSS_Website" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>

<%@ Import Namespace="System.Data.Entity" %>
<%@ Import Namespace="FSOSS.System.DAL" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);

        Database.SetInitializer<FSOSSContext>(new DropCreateDatabaseIfModelChanges<FSOSSContext>());
    }

</script>
