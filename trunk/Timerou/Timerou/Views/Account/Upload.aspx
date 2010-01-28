<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="Mumble.Timerou.Models.Auth.AuthPage<Mumble.Timerou.Models.Pages.UploadModel>" %>

<asp:Content ID="UploadContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" src="http://www.google.com/jsapi?key=ABQIAAAALR8bRKP-XQrzDCAShmrTvxRZcg6rHxTBMZ4Dun_V7KJl7bsRkRTyyWCSl2lWQpqYDZamuBcqyGfb-Q"></script>
    <script type="text/javascript">
        google.load("maps", "2");
    </script>

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
                    <td valign="top" style="width: 300px; padding: 3px;"><div id="map" style="height: 200px; width: 300px;"></div></td>
                    <td valign="top" style="padding: 3px;">
                        <p>Italy</p>
                        <p>Basilicata</p>
                        <p>Matera</p>
                        <p>Via E. de Martino 9, 75100 Matera</p>
                        <p>Lat: 45.2156, Lng: 15.3467</p>
                    </td>
                </tr>
            </table>        
        </div>
        
        <div class="box">
            <h3><%= UIHelper.T("msg.pictureInfos") %></h3>
            
            <fieldset>
                <p>
                    <label><%= UIHelper.T("txt.title") %></label>
                    <input type="text" style="width: 100%" />
                </p>
                
                <p>
                    <label><%= UIHelper.T("txt.body") %></label>
                    <textarea style="width: 100%" class="bodyEditor"></textarea>
                </p>
            </fieldset>
        </div>
    
    </div>
</asp:Content>
