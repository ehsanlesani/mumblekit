<%@ Page Language="C#" Inherits="Mumble.Timerou.Models.Auth.AuthPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Timerou - TimeTour</title>
    
    <script type="text/javascript">
        var BASEURL = '<%= UriHelper.Base %>';
    </script>
    
    <script src="<%= UriHelper.Scripts %>jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>libs/fx.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>Url.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>Utils.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>DetailManager.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>TimebarCom.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>MapCom.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>MapMediaTransition.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>Actions/ShowMediaAction.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>Actions/MaximizeMapAction.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>AjaxNavigation.js" type="text/javascript"></script>
    
    
    <link href="<%= UriHelper.Scripts %>jquery/smoothness/jquery.ui.css" rel="stylesheet" type="text/css" />
    <link href="<%= UriHelper.Css %>Site.css" rel="stylesheet" type="text/css" />
    <link href="<%= UriHelper.Css %>MainPage.css" rel="stylesheet" type="text/css" />
    <link href="<%= UriHelper.Css %>Shared.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        var year = new Date().getFullYear();

        $(document).ready(function() {
            var transition = new MapMediaTransition($("#mapContainer"), $("#detail"));
            var detailManager = new DetailManager(transition);
            var navigation = new AjaxNavigation();
            navigation.addAction("show", new ShowMediaAction(detailManager));
            navigation.addAction("maximizeMap", new MaximizeMapAction(transition));

            $(TimebarCom).bind(TimebarCom.ON_MEDIA_CLICK, function(e, id) {
                detailManager.showMedia(id);
            });

            $(MapCom).bind(MapCom.NAVIGATION_MODE_SELECTED, function(e) {
                window.location.href = "#maximizeMap";
            });

            $(MapCom).bind(MapCom.MAP_READY, function(e) {
                navigation.start();
            });
        });
    </script>
    
</head>
<body>
    <div id="main">
        <div id="header">
            <a href="/">
                <img src="<%=UriHelper.Images %>timerou-logo.png" alt="timerou share your memories" />
            </a>
            <div style="float:right;" id="main-actions">
                <% if (!AccountManager.HasLoggedUser) { %>
                    <%= Html.ActionLink("login", "Login", "Account", new { @class = "blue-link" })%>
                    <%= Html.ActionLink("register", "Register", "Account", new { @class = "blue-link" })%>
                    <%= Html.ActionLink("share", "Share", "Account", new { @class = "blue-link" })%>
                <% } else { %>
                    <%= UIHelper.T("txt.welcome") %> <%= AccountManager.LoggedUser.FirstName %>&nbsp;
                    (
                    <%= Html.ActionLink("my memories", "MyMemories", "Account")%>&nbsp;
                    <%= Html.ActionLink("share", "Share", "Account") %>
                    )
                <% } %>               
            </div>        
        </div>
        <div id="container">  
            <div id="timebarContainer" style="height: 170px;">
                <% Html.RenderPartial("TimebarObject"); %>
            </div>  
            <div id="content" style="width: 981px; overflow:hidden;">
                <div style="width: 981px;">
                    <div id="mapContainer" style="position:absolute; height: 500px; width: 981px; padding-top:19px; margin-right:15px;">
                        <div id="searchMapContainer">
                            <img src="../../Content/Images/searchMapLeftSide.png" id="searchMapLeftSide" alt="" />
                            <input type="text" id="locationKeyword" value="Destination, Places, Events..." />
                            <input type="image" id="locationButton" src="../../Content/Images/search-button.png" alt="search on the map" />
                        </div>
                        <% Html.RenderPartial("MapObject"); %>
                    </div>
                    <div id="detail" style="margin-left: 981px; margin-right:10px;">
                        <div id="titleBar"><span id="title"></span><span id="address"></span></div>
                        <div id="mediaContainer">
                            <div id="imageContainer"></div>
                            <div id="actionContainer">
                                <img src="../../Content/Images/border-bottom-left.png" alt="" id="borderBottomLeft" />
                                <img src="../../Content/Images/border-bottom-right.png" alt="" id="borderBottomRight" />
                            </div>
                        </div>    
                        <!--                    
                        <div id="body">
                            <div id="detailsContainer">
                                <div id="detailsContent"></div>
                                <img src="../../Content/Images/borderGray-top-left.png" alt="" id="borderGrayTopLeft" />
                                <img src="../../Content/Images/borderGray-top-right.png" alt="" id="borderGrayTopRight" />
                                <img src="../../Content/Images/borderGray-bottom-left.png" alt="" id="borderGrayBottomLeft" />
                                <img src="../../Content/Images/borderGray-bottom-right.png" alt="" id="borderGrayBottomRight" />
                            </div>
                        </div>
                        -->
                    </div>     
                </div>
            </div>
            <div>
                contenuto di sotto
            </div>
        </div>
    </div>
</body>
</html>
