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
            detailManager.loadMedias();
        });
    </script>
    
    <link href="../../Content/Css/Timebar.css" rel="stylesheet" type="text/css" />
    <link href="../../Content/Css/Details.css" rel="stylesheet" type="text/css" />
    
    <div class="span-24 last">
        <div id="path"></div>
        <% Html.RenderPartial("TimebarMarkup"); %>
    </div>
    <div style="clear: both;"></div>
    <div id="title" class="title"></div>
    <div class="span-16">
        <div id="mediaArea">
            <div id="mediaContainer"></div>
        </div>
    </div>
    
    <div class="span-8 last">
        <div id="minimapArea">
            <div id="map" style='width: 300px; height: 250px; margin-left: auto;'></div>
        </div>
        <div id="navigation" style="width: 300px; margin-left: auto;"></div>
    </div>    
    <div class="span-24 last">
        <div id="body" class="body"></div>
    </div>
    
    <hr />
    
    <div id="comments" class="span-24 last">
        <h2>Comments</h2>
    
        <div class="box comment">
            <div class="text">
                Il fatto che stia scritto sulla licenza d'uso evidenzia a maggior ragione il nocciolo del problema: tutti noi facciamo un gran parlare di libertà della rete, salvo poi cascare come le classiche pere dagli alberi ogni qual volta si presentano i fatti a sbatterci sul muso che è solo una libertà condizionata.
                È la facilità disarmante con cui i provider fanno pulizia di qualunque contenuto che deve far riflettere. Se nell'era dell'informazione cancellare le persone è ad un clic di distanza, il dito su quel mouse è più potente di quello che teneva il manganello 80 anni fa.
            </div>
            <div class="author"> 10 feb 2010 | Bruno Fortunato </div>
        </div>
        
        <div class="box comment">
            <div class="text">
                Il fatto che stia scritto sulla licenza d'uso evidenzia a maggior ragione il nocciolo del problema: tutti noi facciamo un gran parlare di libertà della rete, salvo poi cascare come le classiche pere dagli alberi ogni qual volta si presentano i fatti a sbatterci sul muso che è solo una libertà condizionata.
                È la facilità disarmante con cui i provider fanno pulizia di qualunque contenuto che deve far riflettere. Se nell'era dell'informazione cancellare le persone è ad un clic di distanza, il dito su quel mouse è più potente di quello che teneva il manganello 80 anni fa.
            </div>
            <div class="author"> 10 feb 2010 | Bruno Fortunato </div>
        </div>
    </div>
    <div id="newComment" class="span-24 last">
        <form method="post" action="#">
            <fieldset>
                <legend>Post a comment</legend>
                <div id="resultDiv"></div>
                <p>
                    <textarea id="comment"></textarea>
                </p>
                <p>
                    <input type="button" value="Post" />
                </p>
            </fieldset>
        </form>
    </div>
    

</asp:Content>
