<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/HomePage.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div id="leftside" class="column span-12">                     
    <img src="../../Content/Images/findApartment-title.png" alt="trova il tuo alloggio!!" />
    <div>
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="400" height="400" id="<%=ResolveUrl("~/Content/swf/italy.swf") %>" align="middle">
	    <param name="allowScriptAccess" value="sameDomain">
	    <param name="movie" value="<%=ResolveUrl("~/Content/swf/italy.swf") %>">
	    <param name="quality" value="high">
	    <param name="bgcolor" value="#ffffff">
	    <param name="menu" value="false">
	    <param name="loop" value="false">
	    <embed src="<%=ResolveUrl("~/Content/swf/italy.swf") %>"italy.swf" quality="high" bgcolor="#ffffff" width="250" height="250" name="<%=ResolveUrl("~/Content/swf/italy.swf") %>" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
    </object>
    </div>
</div>
<div id="centerside" class="column span-8">
          
</div>
<div id="rightside" class="column span-8 last">
    <div id="border-left">                    
    </div>
    <div id="announced">
        <img src="../../Content/Images/announced-by.png" alt="segnalati da noi" class="section-title" />
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
                        
                        if (a.Attachments.Count > 0)
                        {
                            var img = a.Attachments.ElementAt<Attachment>(0);               
                        %>
                                <a href="Structure.aspx/Show/<%=a.Id%>" title="<%=a.Name%>">
                                    <img src="/Public/<%=img.Path %>_lil.jpg" alt="<%=a.Name%>" />
                                </a>
                        <%  }
                            else 
                            {   
                        %>
                                <img src="<%=ResolveUrl("~/Content/Images/no_picture.png") %>" alt="<%=a.Name%>" id="structure-main-pic" style="border:none;" />         
                        <%  }
                    }
                }                                
            }  
        %>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
function ChangeRegion(id) {
  alert('confirm: '+ id);
}
</script>
</asp:Content>
