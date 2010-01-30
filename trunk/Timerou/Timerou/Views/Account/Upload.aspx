<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="Mumble.Timerou.Models.Auth.AuthPage<Mumble.Timerou.Models.Pages.UploadModel>" %>

<asp:Content ID="UploadContent" ContentPlaceHolderID="MainContent" runat="server">

    <% if(Model != null) { %>

    <script type="text/javascript">
        var FORMAT_NOT_ALLOWED = '<%= UIHelper.T("err.formatNotAllowed") %>';
        var PICTURE_UPLOADED = '<%= UIHelper.T("msg.pictureUploaded") %>';
        var UPLOADING = '<%= UIHelper.T("txt.uploading") %>';
        var LOCATION_UNAVAILABLE = '<%= UIHelper.T("err.locationUnavailable") %>';
        var SELECT_PICTURE = '<%= UIHelper.T("msg.selectPicture") %>';
        var SELECT_LOCATION = '<%= UIHelper.T("msg.selectLocation") %>';
        var CHECK_INFORMATIONS = '<%= UIHelper.T("msg.checkInformations") %>';
    </script>

    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script src="<%= UriHelper.Scripts %>jquery/ajaxupload.js" type="text/javascript"></script>
    <script src='<%= UriHelper.Scripts %>Uploader.js' type="text/javascript" ></script>
    <script src='<%= UriHelper.Scripts %>tiny_mce/tiny_mce.js' type="text/javascript" ></script>
    
    <script type="text/javascript">

        $(document).ready(function() {
            var lat = new Number('<%= Model.Lat %>');
            var lng = new Number('<%= Model.Lng %>');
            var zoom = parseInt('<%= Model.Zoom %>');
            var year = parseInt('<%= Model.Year %>');

            var uploader = new Uploader(lat, lng, zoom, year);
            uploader.initialize();
        });
        
    </script>
    
    <div id="uploader">
    
        <div class="box">
            <h3><%= UIHelper.T("msg.selectPeriod") %></h3>
            <div class="yearSlider"></div>
            <h2 style="text-align:center;" id="yearLabel">2010</h2>
        </div>
        
        <div class="box">
            <h3><%= UIHelper.T("msg.selectPicture") %></h3>
            
            <div class="errorbox hidden" id="uploadErrorBox">Error</div>
            
            <table style="width: 100%;">
                <tr>
                    <td style="padding: 3px; width: 100px;">
                        <div id="uploadButton" style="cursor: pointer;">
                            <% if (Model.Picture != null) { %> 
                                <img src="<%= UriHelper.Pictures %><%= Model.Val(x => x.AvatarPath) %>" alt="nophoto" />
                            <% } else { %> 
                                <img src="<%= UriHelper.Images %>nophoto.png" alt="nophoto" />
                            <% } %>
                            
                        </div>
                    </td>
                    <td style="padding: 3px;" >
                        <table width="100%">
                            <tr><td><%= UIHelper.T("msg.clickPictureToChange") %></td></tr>
                            <tr><td><div class="hidden" id="uploadStatus">Status</div></td></tr>
                            <tr><td><div class="hidden" id="uploadProgress"></div></td></tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>

        <div class="box">
            <h3><%= UIHelper.T("msg.selectLocation") %></h3>
        
            <div class="errorbox hidden" id="mapErrorBox">Error</div>
        
            <table width="100%">
                <tr>
                    <td colspan="2" style="padding: 3px;">
                        <div class="fakeInput">
                            <table width="100%">
                                <tr>
                                    <td><input type="text" id="mapSearchKeyword" /></td>
                                    <td style="width: 1%;"><a href="javascript:;" id="mapSearchButton"><img src='<%= UriHelper.Images %>search.png' alt="search" /></a></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>            
                <tr>
                    <td style="vertical-align: top; width: 250px; padding: 3px;"><div id="map" style="height: 250px; width: 300px;"></div></td>
                    <td style="vertical-align: top;padding: 3px;">
                        <h4><%= UIHelper.T("msg.selectedLocation") %></h4>
                        <p id="mapLocationLabel"><%= UIHelper.T("msg.noLocationSelected") %></p>
                        <p id="mapLatLngLabel"></p>
                    </td>
                </tr>
            </table>        
        </div>
        
        <div class="box">        
            <h3><%= UIHelper.T("msg.pictureInfos") %></h3>
            
            <div class="errorbox hidden" id="infoErrorBox">Error</div>
            
            <% using (Html.BeginForm("SavePicture", "Account", FormMethod.Post, new { id = "pictureForm" })) { %>
                <%= Html.Hidden("pictureId", Model.Val(x => x.Id)) %>
                <%= Html.Hidden("tempPictureId") %>
                <%= Html.Hidden("year", Model.Val(x => x.Year))%>
                <%= Html.Hidden("country", Model.Val(x => x.Country)) %>
                <%= Html.Hidden("countryCode", Model.Val(x => x.CountryCode)) %>
                <%= Html.Hidden("region", Model.Val(x => x.Region)) %>
                <%= Html.Hidden("postalCode", Model.Val(x => x.PostalCode)) %>
                <%= Html.Hidden("city", Model.Val(x => x.City)) %>
                <%= Html.Hidden("province", Model.Val(x => x.Province)) %>
                <%= Html.Hidden("address", Model.Val(x => x.Address)) %>
                <%= Html.Hidden("lat", Model.Val(x => x.Lat)) %>
                <%= Html.Hidden("lng", Model.Val(x => x.Lng)) %>
                
                <fieldset>
                    <p>
                        <label><%= UIHelper.T("txt.title")%></label>
                        <%= Html.TextBox("title", Model.Val(x => x.Title), new { id="pictureTitle", style="width: 100%;" })%>
                    </p>
                    
                    <p>
                        <label><%= UIHelper.T("txt.body")%></label>
                        <textarea style="width: 100%" class="bodyEditor" id="pictureBody" name="body"><%= Model.Val(x => x.Body) %></textarea>
                    </p>
                </fieldset>
                
                <input type="submit" value='<%= UIHelper.T("msg.savePicture") %>' />
                <input type="button" value='<%= UIHelper.T("msg.returnToMap") %>' />
            <% } %>            
        </div>    
    </div>
    
    <% } %>
</asp:Content>
