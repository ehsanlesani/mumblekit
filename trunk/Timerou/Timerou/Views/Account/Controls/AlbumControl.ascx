<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Mumble.Timerou.Models.Controls.AlbumModel>" %>

<% if (Model == null) { Response.Write("Model is null"); } else { %>

<script type="text/javascript">
    var NEW_ALBUM = '<%= UIHelper.T("txt.newAlbum") %>';
    var CONFIRM = '<%= UIHelper.T("txt.confirm") %>';
</script>

<script src="<%= UriHelper.Scripts %>jquery/ajaxupload.js" type="text/javascript"></script>
<script src="<%= UriHelper.Scripts %>AlbumControl.js" type="text/javascript"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $(".pictureEditor").css("opacity", 0.5);
        var userId = "<%= Model.User.Id %>";
        var albumControl = new AlbumControl($(".albumControl"), userId);
    });
</script>

<div class="albumControl">
    <div class="albumsList">
        <a href="javascript:;" class="newAlbum"><%= UIHelper.T("txt.newAlbum") %></a>

        <% foreach (var album in Model.Albums) { %>
            <a href="javascript:;" class="album" albumId="<%= album.Id %>"><span class="albumTitle"><%= album.Title %></span></a>
        <% } %>
        
    </div>
    <div class="picturesList">
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
                
        <div class="pictureEditor">
            <a href="javascript:;" class="delete"></a>
            <a href="javascript:;" class="edit"></a>
            <a href="javascript:;" class="profile"></a>
        </div>
        
        <div class="clear"></div>
    </div>
</div>

<% } %>