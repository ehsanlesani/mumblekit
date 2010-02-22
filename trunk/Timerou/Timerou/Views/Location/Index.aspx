<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <script src="../../Scripts/AjaxNavigation.js" type="text/javascript"></script>
    <script src="../../Scripts/Actions/ShowPictureAction.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $(document).ready(function() {
            var navigation = new AjaxNavigation();
            navigation.addAction("showPicture", new ShowPictureAction());
            navigation.start();
        });
    </script>
    
    <h2>Index</h2>
    
    <a href="#showPicture|id=pippi" id="na">navigate</a>
    <a href="#showPicture|id=pappi" id="A1">navigate</a>
    <a href="#showPicture|id=poppi" id="A2">navigate</a>
    
    <div id="date">result</div>

</asp:Content>
