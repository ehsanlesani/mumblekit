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
        
     if (item.Attachments.Count > 0) { %>
            <img src="/Public/<%=item.Attachments.ElementAt<Attachment>(0).Path %>_lil.jpg" alt="nome struttura" class="item-image" />
    <% } %>
    <div class="item-info">
        <p><span class="info-title">Stelle:</span><span class="info-description"><%=item.Quality%></span></p>
        <p><span class="info-title">Descrizione:</span><span class="info-description"><%=item.Description%></span></p>
        <p><span class="info-title">valore:</span><span class="info-description">ciao da me!</span></p>
        <p class="info-btn">entra</p>
    </div>
</div>
<% 
    } 
%>