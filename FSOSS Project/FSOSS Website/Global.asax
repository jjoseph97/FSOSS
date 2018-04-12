<%@ Application Language="C#" %>
<%@ Import Namespace="FSOSS_Website" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>

<%@ Import Namespace="System.Data.Entity" %>
<%@ Import Namespace="FSOSS.System.DAL" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);
    }

    /// <summary>
    /// This method is to handle site-wide validation for incorrect input of HTML tags (possible injection attacks) on input fields
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    void Application_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();

        if (ex is HttpRequestValidationException) // this catches if an HTML tag or injection attack occurs on one of the sites input fields
        {
            Response.Clear();
            Response.StatusCode = 200;
            Response.Redirect("~/HttpValidationException.aspx"); // redirect to this page to handle the exception and display a user-friendly error message
            Response.End();
        }
    }

</script>
