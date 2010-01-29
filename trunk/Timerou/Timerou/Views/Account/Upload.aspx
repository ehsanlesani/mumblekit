<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="Mumble.Timerou.Models.Auth.AuthPage<Mumble.Timerou.Models.Pages.UploadModel>" %>

<asp:Content ID="UploadContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        var FORMAT_NOT_ALLOWED = '<%= UIHelper.T("err.formatNotAllowed") %>';
        var PICTURE_LOADED = '<%= UIHelper.T("msg.pictureUploaded") %>';
        var UPLOADING = '<%= UIHelper.T("txt.uploading") %>';
    </script>

    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script src="<%= UriHelper.Scripts %>jquery/ajaxupload.js" type="text/javascript"></script>
    <script src='<%= UriHelper.Scripts %>Uploader.js' type="text/javascript" ></script>
    <script src='<%= UriHelper.Scripts %>tiny_mce/tiny_mce.js' type="text/javascript" ></script>
    
    <script type="text/javascript">        
    
        $(document).ready(function() {
            //initialize a new uploader in specified container  
            var guid = 1;
            var lat = parseFloat('<%= Model.Lat %>');
            var lng = parseFloat('<%= Model.Lng %>');
            var zoom = parseInt('<%= Model.Zoom %>');

            var uploader = new Uploader(guid, lat, lng, zoom);
        });
        
    </script>
    
    <div id="uploader">
    
        <div class="box">
            <h3><%= UIHelper.T("msg.selectPeriod") %></h3>
            <div class="yearSlider"></div>
            <h2 style="text-align:center;" class="year">2010</h2>
        </div>
        
        <div class="box">
            <h3><%= UIHelper.T("msg.selectPicture") %></h3>
            <table style="width: 100%;">
                <tr>
                    <td style="padding: 3px; width: 100px;">
                        <div id="uploadButton" style="cursor: pointer;"><img src="<%= UriHelper.Images %>nophoto.png" /></div>
                    </td>
                    <td style="padding: 3px;" >
                        <table width="100%">
                            <tr><td><%= UIHelper.T("msg.clickPictureToChange") %></tr>
                            <tr><td><div class="uploadStatus hidden">Status</div></td></tr>
                            <tr><td><div class="uploadProgress hidden"></div></td></tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>

        <div class="box">
            <h3><%= UIHelper.T("msg.selectLocation") %></h3>
        
            <table>
                <tr><td colspan="2" style="padding: 3px;"><input type="text" /><input type="button" value='<%= UIHelper.T("txt.search") %>' /></td></tr>            
                <tr>
                    <td valign="top" style="width: 300px; padding: 3px;"><div id="map" style="height: 500px; width: 500px;"></div></td>
                    <td valign="top" style="padding: 3px;">
                        <p class="country">Italy</p>
                        <p class="region">Basilicata</p>
                        <p class="city">Matera</p>
                        <p class="address">Via E. de Martino 9, 75100 Matera</p>
                        <p class="latlng">Lat: 45.2156, Lng: 15.3467</p>
                    </td>
                </tr>
            </table>        
        </div>
        
        <div class="box">        
            <h3><%= UIHelper.T("msg.pictureInfos") %></h3>
            
            <% using (Html.BeginForm("SavePicture", "Account")) { %>
                <input type="hidden" name="tempPictureId" />
                <input type="hidden" name="country" />
                <input type="hidden" name="region" />
                <input type="hidden" name="postalCode" />
                <input type="hidden" name="city" />
                <input type="hidden" name="province" />
                <input type="hidden" name="lat" />
                <input type="hidden" name="lng" />                
                
                <fieldset>
                    <p>
                        <label><%= UIHelper.T("txt.title")%></label>
                        <input type="text" name="title" style="width: 100%" />
                    </p>
                    
                    <p>
                        <label><%= UIHelper.T("txt.body")%></label>
                        <textarea style="width: 100%" class="bodyEditor" name="body"></textarea>
                    </p>
                </fieldset>
            <% } %>            
        </div>    
    </div>
</asp:Content>
