<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<Mumble.Web.StarterKit.Models.ExtPartial.Page>>" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>



<%
    foreach (var page in Model) 
    { 
        %>
        <div class="sidepage">
            <%=page.Body%>
        </div>
        <%
    }
%>