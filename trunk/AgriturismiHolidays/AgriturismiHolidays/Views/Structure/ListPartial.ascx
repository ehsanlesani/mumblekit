<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<Accommodation>>" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>

<%     
    foreach(var item in Model) 
    { 
%>        
<div class="result-item">
    
    <%
        if (!item.Attachments.IsLoaded)
            item.Attachments.Load();
        
        if (item.Attachments.Count > 0) { 
    %>
            <img src="/Public/<%=item.Attachments.ElementAt<Attachment>(0).Path %>_lil.jpg" alt="nome struttura" class="item-image" />
    <% } %>
    <div class="item-info">
        
        <%
            if (item.Quality > 0)
            {
        %>
            <p>
                <% for (int i = 0; i < item.Quality; i++) { %>
                        <img src="../../Content/Images/star_16x16.png" alt="<%=item.Quality%> stelle" class="quality" />
                <% } %>
            </p>
        <%
            }
        %>
        <p><span class="info-title"><%=item.Name%></span></p>
        <p><span class="info-title">Descrizione:</span><span class="info-description"><%=item.Description%></span></p>
        <p class="info-btn"><%= Html.ActionLink("dettagli", "Show", "Structure", new { Id = item.Id }, null) %></p>
    </div>
</div>
<% 
    } 
%>