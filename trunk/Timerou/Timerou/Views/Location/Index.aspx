<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../Scripts/AjaxNavigation.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            var ajaxNavigation = new AjaxNavigation();
            $("#nav").click(function() { ajaxNavigation.goTo(""); });
        });
    </script>
    
    <h2>Index</h2>
    
    <a href="javascript:;" id="nav">navigate</a>
    
    <div id="date">result</div>

</asp:Content>
