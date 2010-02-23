<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script src="../../Scripts/AjaxNavigation.js" type="text/javascript"></script>
    <script src="../../Scripts/Timebar.js" type="text/javascript"></script>
    <script src="../../Scripts/Actions/ShowPictureAction.js" type="text/javascript"></script>
    <script src="../../Scripts/DetailManager.js" type="text/javascript"></script>
    
    <script type="text/javascript">

        var bounds = '<%= ViewData["Bounds"] %>';
        var year = parseInt('<%= ViewData["Year"] %>');

        $(document).ready(function() {
            var navigation = new AjaxNavigation();
            navigation.addAction("showPicture", new ShowPictureAction());
            navigation.start();

            var detailManager = new DetailManager(bounds, year);
            var timebar = new Timebar();

            $(timebar).bind(Timebar.YEAR_CHANGED, function() {
                detailManager.setYear(timebar.getYear());
            });

            google.maps.event.addListener(detailManager.map, "bounds_changed", function() {
                google.maps.event.clearListeners(detailManager.map, "bounds_changed");
                timebar.initialize(year);
                timebar.setBounds(Utils.googleBoundsToBounds(detailManager.map.getBounds()));
                timebar.loadPictures();
                //adjust zoom level after use of fitBounds
                detailManager.map.setZoom(detailManager.map.getZoom() + 1);
            });
        });
    </script>
    
    <link href="../../Content/Css/Timebar.css" rel="stylesheet" type="text/css" />
    
    <div id="path"></div>
    <% Html.RenderPartial("TimebarMarkup"); %>
    <div id="title"></div>
    <div id="address"></div>
    <div id="mediaArea">
        <div>
            <a href="#show" id="previousButton">previous</a>
            <a href="#show" id="nextButton">next</a>
        </div>
        <div id="mediaContainer"></div>
    </div>
    <div id="minimapArea">
        <div id="map" style='width: <%= ViewData["MapWidth"] %>px; height: <%= ViewData["MapHeight"] %>px;'></div>
    </div>
    <div id="description"></div>
    <div id="locationRelatedContainer"></div>
    <div id="userRelatedContainer"></div>

</asp:Content>
