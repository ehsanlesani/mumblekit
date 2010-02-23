<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script src="../../Scripts/AjaxNavigation.js" type="text/javascript"></script>
    <script src="../../Scripts/Timebar.js" type="text/javascript"></script>
    <script src="../../Scripts/Actions/ShowMediaAction.js" type="text/javascript"></script>
    <script src="../../Scripts/DetailManager.js" type="text/javascript"></script>
    
    <script type="text/javascript">

        var bounds = '<%= ViewData["Bounds"] %>';
        var year = parseInt('<%= ViewData["Year"] %>');

        $(document).ready(function() {
            var detailManager = new DetailManager(bounds, year);
        });
    </script>
    
    <link href="../../Content/Css/Timebar.css" rel="stylesheet" type="text/css" />
    
    <style type="text/css">
        #navigation a:link, #navigation a:visited, #navigation a:hover
        {
            height: 50px;
            width: 50px;
            padding: 2px;
            border: solid 1px #CCCCCC;
            display: block;
            float: left;
            margin-right: 3px;
        }
        
        #navigation a img
        {
            height: 50px;
            width: 50px;
            border: 0px;
        }
        
        #navigation 
        {
            margin-bottom: 5px;
        }
    </style>
    
    <div class="span-24 last">
        <div id="path"></div>
        <% Html.RenderPartial("TimebarMarkup"); %>
    </div>
    <div id="navigation" class="span-24"></div>
    <div style="clear: both;"></div>
    <div id="title"></div>
    <div class="span-16">
        <div id="mediaArea">
            <div id="mediaContainer"></div>
        </div>
    </div>
    
    <div class="span-8 last">
        <div id="minimapArea">
            <div id="map" style='width: <%= ViewData["MapWidth"] %>px; height: <%= ViewData["MapHeight"] %>px; margin-left: auto;'></div>
        </div>
        <div id="locationRelatedContainer"></div>
        <div id="userRelatedContainer"></div>
    </div>    
    <div id="body" class="span-24 last"></div>
    

</asp:Content>
