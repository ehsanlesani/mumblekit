<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.Common" %>

<div id="footer">
    <p id="email"><span class="title">E-Mail.</span><span class="content">info@expoholidays.com</span></p>
    <p id="tel"><span class="title">Tutti i diritti riservati</span></p>
    <p id="menu">
    <%
        if (ViewData["Footer"] != null) 
        {
            var list = ViewData["Footer"] as IEnumerable<MenuTab>;

            int max = list.Count();
            int i = 1;
            foreach (MenuTab tab in list) 
            { 
    %>            
                <span class="title">
                    <a href="">
                        <%=tab.Text%>
                    </a>    
                </span>    
    <%            
                if(i<max)
    %>
                    <span class="content">/</span>
    <%  
                i++;
            }
        }
    %>
    </p>
</div>