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

    void Application_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();

        if (ex is HttpRequestValidationException)
        {
            string script = "</sc" + "ript>";
            Response.Clear();
            Response.StatusCode = 200;
            Response.Write(@"
                <html>
                <head><title>HTML Not Allowed</title>
                </head>
                <body style='font-family: Arial, Sans-serif;'>
                <h1>Oops!</h1>
                <p>I'm sorry, but HTML entry is not allowed on that page.</p>
                <p>Please make sure that your entries do not contain 
                any angle brackets like &lt; or &gt;.</p>
                <p><a href='javascript:back()'>Go back</a></p>
                </body>
                </html>
                <script language='JavaScript'><!--
                function back() { history.go(-1); } //-->" + script);
                Response.End();
            }
        }

</script>
