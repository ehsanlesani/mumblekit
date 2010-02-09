<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<StructureViewModel>" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
    <% 
        var accomodation = ViewData.Model.Accommodation; 
        
        if (!accomodation.Attachments.IsLoaded)
                accomodation.Attachments.Load();

        if (!accomodation.MunicipalitiesReference.IsLoaded)
            accomodation.MunicipalitiesReference.Load();
    %>
        <div id="badge" class="span-8">
        <%
            string location = accomodation.MunicipalitiesReference.Value.Name +", "+ accomodation.Street +" "+ accomodation.StreetNr;
            
            if (accomodation.Attachments.Count > 0)
            {
                var img = accomodation.Attachments.ElementAt<Attachment>(0);               
        %>
                <a href="/Public/<%=img.Path %>.jpg" title="<%=img%>" class="pirobox">
                    <img src="/Public/<%=img.Path %>_lil.jpg" alt="<%=img.Title%>" id="structure-main-pic" />
                </a>
        <%  }
            else 
            {   
        %>
                <img src="<%=ResolveUrl("~/Content/Images/no_picture.png") %>" alt="<%=accomodation.Name%>" id="structure-main-pic" style="border:none;" />         
        <%  } %>
        <div class="span-5">
            <p id="badge-title">
                <span class="lightbrown">
                <%=accomodation.Name%>
                </span>
            </p>
            <div id="badge-details">
                <p><span class="lightorange"><%=location%></span></p>
                <p><span class="lightbrown">Tel.</span><span class="lightorange"><%=accomodation.Tel%></span></p>
                <p><span class="lightbrown">Fax.</span><span class="lightorange"><%=accomodation.Fax%></span></p>
                <p><span class="lightbrown">E-mail</span><span class="lightorange"><%=accomodation.Email%></span></p>
            </div>    
        </div>
    </div>
    <div id="structure-description" class="span-15 last">
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
    <div class="span-24 last">
        <div id="tariffe" class="span-8  inner-section">    
            <img src="<%=ResolveUrl("~/Content/Images/prices-title.png")%>" alt="servizi" class="section-title" />
            <%
                if (!accomodation.Rooms.IsLoaded)
                    accomodation.Rooms.Load();

                foreach (Room r in accomodation.Rooms)
                {
                    if (!r.RoomPriceList.IsLoaded)
                        r.RoomPriceList.Load();

                    foreach (RoomPriceList rp in r.RoomPriceList) 
                    {
                        if (!rp.PriceListSeasonsReference.IsLoaded)
                            rp.PriceListSeasonsReference.Load();
                        
                        //rp.PriceListSeasons
                    }
                }
                
            %>    
        </div>    
        <div id="dove" class="span-8  inner-section">
            <img src="<%=ResolveUrl("~/Content/Images/where-title.png")%>" alt="servizi" class="section-title" />
            <% if (accomodation.ShowMap.GetValueOrDefault())
               {
                   string geolocation = Server.UrlEncode(accomodation.MunicipalitiesReference.Value.Name.Trim() + "," + accomodation.Street.Trim() +" "+ accomodation.StreetNr.Trim());
                   char label = (accomodation.Name.Length > 0) ? accomodation.Name[0] : 'S';               
            %>
                <img style="margin-bottom:10px;" src="http://maps.google.com/maps/api/staticmap?markers=color:red|label:<%=label%>|<%=geolocation%>&zoom=14&size=300x300&sensor=false&key=ABQIAAAAbxDwSkSkkRmlIPj2OQG-6RQ976ET3a5nyeSd_F-Qgih1n2nlaxRdfBT2uWFHuUz_WnZJfFDRnEn2Sw" alt="<%=accomodation.Street%>" />
            <% } %>
            <p>
            <%=accomodation.WhereWeAre%>
            </p>
        </div>    
        <div id="servizi" class="span-8 last inner-section">
            <img src="<%=ResolveUrl("~/Content/Images/services-title.png")%>" alt="servizi" class="section-title" />
            <ul class="service-ul">
            <%
                if (!accomodation.Services.IsLoaded)
                    accomodation.Services.Load();

                foreach (Service service in accomodation.Services)
                {                 
            %>
                    <li title="<%=service.Description%>"><%=service.Name%></li>
            <%  } %>
            </ul>
        </div>
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
