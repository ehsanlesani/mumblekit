<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>
<%@ Import Namespace="System.IO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div id="leftside" class="column span-12">                     
    <img src="../../Content/Images/findApartment-title.png" alt="trova il tuo alloggio!!" />
    <div id="searchForm">
    <% Html.BeginForm("List", "Structure"); %>
    <table class="reset" cellpadding="0" cellspacing="0" id="searchTable">
    <tr>    
        <td align="right">Regione:</td>    
        <td><%=Html.DropDownList("RegionItems")%></td>
        <td align="right">Tipologia:</td>
        <td><%=Html.DropDownList("Category")%></td>
        <td><input id="doAccommodationSearch" title="cerca" type="submit" value="cerca" /></td>
    </tr>
    <tr>
        <td align="right">Provincia:</td>
        <td colspan="3">
            <select id="ProvinceItems" name="ProvinceItems">
                <option value=""> - provincia - </option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="right">Comune:</td>
        <td colspan="3">
            <select id="MunicipalityItems" name="MunicipalityItems">
                <option value=""> - comune - </option>
            </select>
        </td>
    </tr>
    </table>
    <% Html.EndForm(); %>
    </div>
    <div>
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="400" height="400" id="<%=ResolveUrl("~/Content/swf/italy.swf") %>" align="middle">
	    <param name="allowScriptAccess" value="sameDomain">
	    <param name="movie" value="<%=ResolveUrl("~/Content/swf/italy.swf") %>">
	    <param name="quality" value="high">
	    <param name="bgcolor" value="#ffffff">
	    <param name="menu" value="false">
	    <param name="loop" value="false">
	    <embed src="<%=ResolveUrl("~/Content/swf/italy.swf") %>" quality="high" bgcolor="#ffffff" width="400" height="400" name="<%=ResolveUrl("~/Content/swf/italy.swf") %>" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
    </object>    
    </div>
    <div>
        <%=ViewData["StaticPage"]%>
    </div>
</div>
<div id="rightside" class="column span-12 last">
    <p id="subscription">Vuoi inserire la tua struttura? <%=Html.ActionLink("iscriviti", "Register", "Account", null, new { @class="subscription-link" })%></p>
    <div id="announced">
        <img src="../../Content/Images/announced-by.png" alt="segnalati da noi" class="section-title" id="advice-by-title" />
        <%
            if (ViewData["Showcase"] != null) 
            {
                IEnumerable<Accommodation> alist = ViewData["Showcase"] as IEnumerable<Accommodation>;

                // Quante belle if :P
                if (alist != null) 
                {
                    foreach (Accommodation a in alist) 
                    {
                        if (!a.Attachments.IsLoaded)
                            a.Attachments.Load();

                        if (!a.MunicipalitiesReference.IsLoaded)
                            a.MunicipalitiesReference.Load();

                        string hrefPath = "Structure.aspx/Show/" + a.Id;
                        
                        Attachment img = null;
                        if (a.Attachments.Count > 0)
                        {
                            img = a.Attachments.ElementAt<Attachment>(0);
                            
                            string imgPath = "/Public/" + img.Path + "_lil.jpg";

                            %>
                            <div class="floated-left">
                                <a href="<%=hrefPath%>" title="<%=a.Name%>">                                
                                    <img src="<%=imgPath%>" alt="<%=a.Name%>" />                                
                                    <div style="text-align:center; color:Black;"><b><%=a.Municipalities.Name%></b><br /><i><%=a.Name%></i></div>
                                </a>
                            </div>
                            <%
                        }
                        else 
                        {
                        %>
                        <div class="floated-left">
                            <a href="<%=hrefPath%>" title="<%=a.Name%>">
                                <img src="<%=ResolveUrl("~/Content/Images/no_picture.png") %>" alt="<%=a.Name%>" />
                                <div style="text-align:center; color:Black;"><b><%=a.Municipalities.Name%></b><br /><i><%=a.Name%></i></div>
                            </a>    
                        </div>
                        <%
                        }
                    }
                }                                
            }  
        %>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
<script src="<%=ResolveUrl("~/Content/JS/combo.js")%>" type="text/javascript"></script>
<script type="text/javascript">
    /// <reference path="../../Content/JS/jquery/jquery-1.3.2-vsdoc2.js" />

    function ChangeRegion(id) { 
        var regionList = new Array ("","abruzzo", "basilicata", "calabria", "campania", "emilia", "friuli", "lazio", "liguria", "lombardia"
        ,"marche", "molise", "piemonte", "puglia", "sardegna", "sicilia", "toscana", "trentino", "umbria", "valledaosta", "veneto");
        
        var itemId = jQuery.inArray(id, regionList);
        $("#RegionItems option").eq(itemId).attr("selected", "selected");
        $('select#RegionItems').change();
    }

    $(document).ready(function() {

        var selection = new HierarchicalSelection();
        selection.registerSelect("RegionItems", "ProvinceItems", "id", "/SelectValues.aspx/Provinces", function() { selection.clearChild("select[name='MunicipalityItems']"); });
        selection.registerSelect("ProvinceItems", "MunicipalityItems", "id", "/SelectValues.aspx/Municipalities", function() { });

        $('input#doAccommodationSearch[type="submit"]').click(function(event) {
            var regionVal = $('select[name="RegionItems"] option:selected').val();
            var categoryVal = $('select[name="Category"] option:selected').val();

            var showAlert = false;
            if (regionVal == undefined || categoryVal == undefined)
                showAlert = true;

            if (regionVal.length == 0 || categoryVal == 0)
                showAlert = true;

            if (showAlert) {
                alert('è necessario selezionare una categoria ed una regione per effettuare la ricerca');
                event.preventDefault();
            }
        });

        $('select[name="RegionItems"]').change(function() {

            $('select[name="ProvinceItems"]').effect("highlight", { color: '#BC161B' }, 1000);
        });

        $('select[name="ProvinceItems"]').change(function() {

            $('select[name="MunicipalityItems"]').effect("highlight", { color: '#BC161B' }, 1000);
        });
    });
</script>
</asp:Content>
