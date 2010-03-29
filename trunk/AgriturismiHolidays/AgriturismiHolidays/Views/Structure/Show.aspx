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
                <img src="/Public/<%=img.Path %>_lil.jpg" alt="<%=img.Title%>" id="structure-main-pic" />                
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
                <a href="/Public/<%=img.Path %>.jpg" title="<%=img%>" class="lightbox gal-image">
                    <img src="/Public/<%=img.Path %>_lil.jpg" alt="<%=img.Description%>" />
                </a>    
        <% 
                }
            }
        %>
    </div>
    <div class="span-24 last">
        <div id="tariffe" class="span-11  inner-section">    
            <img src="<%=ResolveUrl("~/Content/Images/prices-title.png")%>" alt="servizi" class="section-title" />
            <%
                if (!accomodation.Rooms.IsLoaded)
                    accomodation.Rooms.Load();

                foreach (Room r in accomodation.Rooms)
                {
                    StarterKitContainer cnt = new StarterKitContainer();
                    var price = from p in cnt.RoomPriceList where p.Rooms.Id == r.Id select p;

                    var lastinsertedroom = "";
                    
                    %>
                    
                    <table cellpadding="0" cellspacing="0" class="room-prices">
                    <tr>
                    
                    <%
                    foreach (RoomPriceList p in price) 
                    {
                        if (!p.PriceListSeasonsReference.IsLoaded)
                            p.PriceListSeasonsReference.Load();

                        if (!p.PriceListEntriesReference.IsLoaded)
                            p.PriceListEntriesReference.Load();

                        if (!lastinsertedroom.Equals(p.PriceListEntries.Description))
                        {
                            lastinsertedroom = p.PriceListEntries.Description;
                            Response.Write("<td colspan=\"6\"><b>"+ r.Name +"</b> (<i>" + lastinsertedroom + "</i>)</td></tr><tr>");
                        }
                        
                        %>                        
                        
                        <td><%=p.PriceListSeasons.Description%></td>                        
                        <td><%=p.Price.GetValueOrDefault().ToString("0.00")%>&nbsp;&euro;</td>                                               
                        
                        <%
                    }                    
                    
                    %>
                    
                    </tr>
                    </table>
                        
                    <%
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
        <div id="servizi" class="span-5 last inner-section">
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
    <script type="text/javascript" src="<%=ResolveUrl("~/Content/JS/jquery/jquery.lightbox-0.5.js") %>"></script>
    <link rel="stylesheet" type="text/css" href="<%=ResolveUrl("~/Content/Css/jquery/jquery.lightbox-0.5.css") %>" media="screen" />
    <script type="text/javascript">
    $(document).ready(function(){
        
        $('a.lightbox').lightBox();
    });
    </script>
</asp:Content>
