/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Utils.js" />
/// <reference path="Url.js" />
/// <reference path="libs/google.maps-v3-vsdoc.js" />
/// <reference path="MapMediaTransition.js" />

function DetailManager(transition) {
    this.transition = transition;
    this.displayedMedias = {}; //cache
}

DetailManager.MEDIA_DISPLAYED = "mediaDisplayed";

DetailManager.prototype = {

    loadMedia: function(id, callback) {
        var self = this;

        $.post(Url.LoadMedia, { id: id },
            function(response) {
                if (response.error) {
                    Utils.showSiteError(response.message);
                    return;
                }
                callback(response.media);
            }, "json");
    },

    getMediaById: function(id, callback) {
        var self = this;

        //search into cache
        if (!Utils.isNullOrUndef(this.displayedMedias[id])) {
            callback(this.displayedMedias[id]);
            return;
        }

        //try to get from timebar
        //TODO

        //and finally try to load single media from server
        this.loadMedia(id, callback);
    },

    displayMedia: function(id) {
        var self = this;

        this.getMediaById(id, function(media) {
            if (media == null) {
                Utils.showSiteError("Media is null");
                return;
            }

            self.displayedMedias[media.id] = media;

            if (media.type == "Picture") {
                $("#detail #mediaContainer #imageContainer")
                    .empty()
                    .append($("<img />")
                        .attr("src", Url.Pictures + media.pictureData.optimizedPath)
                    );

                //why not a different default title? :)
                if (media.title != media.address)
                    $("#titleBar #title").html(media.title);

                $("#titleBar #address").html(media.address.length > 0 ? "(" + media.address + ")" : "");
                $("#detail #body #detailsContent").html(media.body.length > 300 ? media.body.substr(0, 300) + "..." : media.body);
            } else {
                alert("media cannot be displayed: " + media.type);
            }

            self.transition.minimizeMap();
            MapCom.markLocation(media.lat, media.lng);

            $(self).trigger(DetailManager.MEDIA_DISPLAYED, id);
        });
    },

    showMedia: function(id) {
        window.open("#show|id=" + id, "_self");
    }
};