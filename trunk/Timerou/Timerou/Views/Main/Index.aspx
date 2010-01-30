<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Index</title>
</head>
<body>
<%
    
    Response.Write(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
    
    var culture = System.Globalization.CultureInfo.GetCultureInfo("en-US");
    float number = 45.3463737f;
    Response.Write(number.ToString());
     %>

<br />
<%= number %>
    <div>
        <div class="header">Header</div>
        <div class="content">
        
        </div>
        <div class="footer"></div>
    </div>
</body>
</html>
