<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Mumble.Friendsheep.Models.Controls.AlbumModel>" %>

<% if (Model == null) { Response.Write("Model is null"); } else { %>

<div class="albumControl">
    <div class="albumsList">
        <a href="javascript:;" class="album" album_id="">Album</a>
        <a href="javascript:;" class="album" album_id="">Album</a>
        <a href="javascript:;" class="album" album_id="">Album</a>
        <a href="javascript:;" class="album" album_id="">Album</a>
        <a href="javascript:;" class="activeAlbum" album_id="">Album</a>
        <a href="javascript:;" class="album" album_id="">Album</a>
        <a href="javascript:;" class="album" album_id="">Album</a>
        <a href="javascript:;" class="album" album_id="">Album</a>
        <a href="javascript:;" class="album" album_id="">Album</a>
        <a href="javascript:;" class="album" album_id="">Album</a>
        <a href="javascript:;" class="album" album_id="">Album</a>

        <% foreach (var album in Model.Albums) { %>
            <a href="javascript:;" class="album" album_id="<%= album.Id %>"><%= album.Title %></a>
        <% } %>
    </div>
    <div class="picturesList">
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <a href="javascript:;" class="picture"><img src="<%= UriHelper.Pictures %>default_avatar.png" alt="pict" /></a>
        <div class="clear"></div>
    </div>
</div>

<% } %>