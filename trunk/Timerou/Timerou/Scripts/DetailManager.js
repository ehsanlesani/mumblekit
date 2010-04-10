/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Utils.js" />
/// <reference path="Url.js" />
/// <reference path="libs/google.maps-v3-vsdoc.js" />

function DetailManager() {    
    this.initialize();
}

DetailManager.prototype = {
    initialize: function() {
        this._initializeNavigation();
    },
    
     _initializeNavigation: function() {
        var navigation = new AjaxNavigation();
        navigation.addAction("show", new ShowMediaAction(this));
        navigation.start();
    },

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

        //next search in current loaded page
        if (this.medias != null) {
            for (var m in this.medias) {
                var media = this.medias[m];
                if (media.id == id) {
                    callback(media);
                    return;
                }
            }
        }

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
                $("#mediaContainer")
                    .empty()
                    .append($("<img />")
                        .attr("src", Url.Pictures + media.pictureData.optimizedPath)
                    );

                $("#title").html(media.title);
                $("#address").html(media.address);
                $("#body").html(media.body);
                $(".media").removeClass("activeMedia");
                $("#" + media.id).addClass("activeMedia");

                if (self.marker != null) {
                    self.marker.setMap(null);
                }

                var position = new google.maps.LatLng(media.lat, media.lng);

                self.marker = new google.maps.Marker({
                    position: position,
                    map: self.map
                });

                self.map.panTo(position);
            }
        });
    }

    

   
}