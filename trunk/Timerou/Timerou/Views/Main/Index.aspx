﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Index</title>
    
    <script type="text/javascript">
        var BASEURL = '<%= UriHelper.Base %>';
    </script>
    
    <script src="<%= UriHelper.Scripts %>jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>jquery/jquery-ui-1.7.2.custom.min.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>Url.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>Utils.js" type="text/javascript"></script>
    <script src="<%= UriHelper.Scripts %>MapCom.js" type="text/javascript"></script>   
    <script src="<%= UriHelper.Scripts %>Timebar.js" type="text/javascript"></script>
    
    <link href="<%= UriHelper.Scripts %>jquery/smoothness/jquery.ui.css" rel="stylesheet" type="text/css" />
    <link href="../../Content/Css/Timebar.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        var year = new Date().getFullYear();

        $(document).ready(function() {

            $("#hibridButton").click(function() {
                MapCom.changeType(MapCom.MAPTYPE_HYBRID);
            });

            $("#roadButton").click(function() {
                MapCom.changeType(MapCom.MAPTYPE_ROAD);
            });

            $("#searchButton").click(function() {
                var key = $("#locationKeyword").val();
                if (key.length > 3) {
                    MapCom.searchLocation(key);
                } else {
                    alert("Min keyword length: 3");
                }
            });

            var timebar = new Timebar();
            $(MapCom).bind("mapReady", function() {
                timebar.initialize();
            });

        });
    </script>
    
    <style type="text/css">
        html, body 
        {
            margin: 0px;
            border: 0px;
            height: 100%;
            font-family: Verdana;
        }
        
        .header 
        {
            height: 30px;
            border-bottom: solid 2px #333333; 
            padding: 5px;   
        }
        
        .actions 
        {
            height: 25px;
            border-bottom: solid 2px #333333; 
            padding: 5px;
        }
        
        .timebar 
        {
            height: 100px;
            border-bottom: solid 2px #333333; 
            padding: 5px;
            text-align: center;
            overflow:hidden;
        }
        
        .title
        {
            font-size: 20px;
        }

        .mapContainer 
        {
            position:absolute;
            top: 185px;
            bottom: 0px;
            left: 0px;
            right: 0px;
        }
        
            
    </style>
</head>
<body>
    <div class="header">
        <div style="float:right;">
            <a href="/Account/Login">login</a> | <a href="/Account/Register">register</a> | <a href="/Account/Upload">upload</a>
        </div>
        <span class="title">Timerou preview</span>
    </div>
    <div id="timebar" class="timebar">
        <a href="javascript:;" class="backButton"></a>
        <div class="picturesContainer"></div>
        <div class="barBegin"></div>
        <div class="bar">
            <div class="pointer"></div>
        </div>
        <div class="barEnd"></div>
        <a href="javascript:;" class="forwardButton"></a>
        <div class="barLoading"><img src="<%= UriHelper.Images %>ajaxLoading.gif" alt="loading..." /></div>
    </div>
    <div class="actions">
        <div style="float:right;">
            <a href="javascript:;" id="hibridButton">Hibrid map type</a> | <a href="javascript:;" id="roadButton">Road map type</a>
        </div>
        <input type="text" id="locationKeyword" />
        <a href="javascript:;" id="searchButton">GO</a>        
    </div>
    <div class="mapContainer">
        <% Html.RenderPartial("MapObject"); %>
    </div>
</body>
</html>
