<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Internal.Master" Inherits="System.Web.Mvc.ViewPage<StructureViewModel>" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
    <% 
        var accomodation = ViewData.Model.Accommodation; 
        
        if (!accomodation.Attachments.IsLoaded)
                accomodation.Attachments.Load();    
    %>
        <div id="badge" class="span-10">
        <%
            if (accomodation.Attachments.Count > 0)
            {
                var img = accomodation.Attachments.ElementAt<Attachment>(0);               
        %>
                <a href="/Public/<%=img.Path %>.jpg" title="<%=img%>" class="pirobox_gall">
                    <img src="/Public/<%=img.Path %>_lil.jpg" alt="<%=img.Description%>" id="structure-main-pic" />
                </a>
        <%  }
            else 
            {
        %>
             <img src="<%=ResolveUrl("~/Content/Image/no_picture.jpeg") %>" alt="<%=img.Description%>" id="structure-main-pic" style="border:none;" />         
        <%  } %>
        <div class="span-5">
            <p id="badge-title">
                <span class="lightbrown">
                <%=accomodation.Name%>
                </span>
            </p>
            <div id="badge-details">
                <p><span class="lightorange"><%=accomodation.Street %></span></p>
                <p><span class="lightbrown">Tel.</span><span class="lightorange"></span></p>
                <p><span class="lightbrown">Fax.</span><span class="lightorange">0835 50 90 78</span></p>
                <p><span class="lightbrown">email</span><span class="lightorange"><%=accomodation.Email %></span></p>
            </div>    
        </div>
    </div>
    <div id="structure-description" class="span-13 last">
        <%=accomodation.Description%>
    </div>    
    <div id="gallery" class="span-24 last">
        <%
            if (accomodation.Attachments.Count > 1)
            {
                var attachments = accomodation.Attachments;
                foreach (Attachment img in attachments)
                {
        %>
                <a href="/Public/<%=img.Path %>.jpg" title="<%=img%>" class="pirobox_gall gal-image">
                    <img src="/Public/<%=img.Path %>_lil.jpg" alt="<%=img.Description%>" />
                </a>    
        <% 
                }
            }
        %>
    </div>
    <div id="tariffe" class="span-8">        
    </div>
    <div id="dove">
    </div>
    <div id="servizi">
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/Content/Css/jquery/white/style.css") %>" title="white" type="text/css" media="screen, projection" />
    <script type="text/javascript" src="<%=ResolveUrl("~/Content/JS/jquery/pirobox.1_2_min.js") %>"></script>
    <script type="text/javascript">
    $(document).ready(function(){
    $().piroBox({
          my_speed: 300, //animation speed
          bg_alpha: 0.5, //background opacity
          radius: 4, //caption rounded corner
          scrollImage : false, // true == image follows the page _|_ false == image remains in the same open position
                               // in some cases of very large images or long description could be useful.
          slideShow : 'true', // true == slideshow on, false == slideshow off
          slideSpeed : 3, //slideshow
          pirobox_next : 'piro_next', // Nav buttons -> piro_next == inside piroBox , piro_next_out == outside piroBox
          pirobox_prev : 'piro_prev', // Nav buttons -> piro_prev == inside piroBox , piro_prev_out == outside piroBox
          close_all : '.piro_close' // add class .piro_overlay(with comma)if you want overlay click close piroBox
          });
    });
    </script>
</asp:Content>
