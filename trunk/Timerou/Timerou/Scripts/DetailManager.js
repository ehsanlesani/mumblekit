/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Utils.js" />
/// <reference path="Url.js" />
/// <reference path="libs/google.maps-v3-vsdoc.js" />

function DetailManager(bounds, year) {
    this.map = null;
    this.bounds = Utils.stringToBounds(bounds);
    this.year = year;
    this.pageSize = 13;
    this.page = 1;
    this.medias = null;
    this.marker = null;
    this.totalMedias = 0;
    this.displayedMedias = {};  //medias loader for browser back and forward button

    this.initialize();
}

DetailManager.prototype = {
    initialize: function() {
        this._initializeMinimap();
        this._initializeNavigation();
    },

    loadMedias: function(callback) {
        var self = this;

        $.post(Url.LoadMedias, {
            swlat: this.bounds.swlat,
            swlng: this.bounds.swlng,
            nelat: this.bounds.nelat,
            nelng: this.bounds.nelng,
            year: this.year,
            page: this.page,
            pageSize: this.pageSize
        }, function(response) {
            if (response.error) {
                Utils.showSiteError(response.message);
                return;
            }

            self.medias = [];
            self.totalMedias = response.totalCount;
            self.medias = self.medias.concat(response.medias);

            $("#navigation").empty();
            for (var i = 0; i < self.medias.length; i++) {
                var media = self.medias[i];
                $("#navigation")
                    .append($("<a />")
                        .attr("href", "#show|id=" + media.id + "")
                        .addClass("media")
                        .attr("id", media.id)
                        .append($("<img />")
                            .attr("src", Url.Pictures + media.pictureData.avatarPath)
                        )
                    );
            }

            //add navigation buttons
            var previousButton = $("<a />")
                .attr("href", "javascript:;")
                .addClass("previous");

            if (self.page > 1) {
                previousButton.css("opacity", 1);
                previousButton.click(function() {
                    self.page--;
                    self.loadMedias();
                });
            } else {
                previousButton.css("opacity", 0.5);
            }

            $("#navigation").append(previousButton);

            var nextButton = $("<a />")
                .attr("href", "javascript:;")
                .addClass("next");

            if (self.totalMedias > self.page * self.pageSize) {
                nextButton.css("opacity", 1);
                nextButton.click(function() {
                    self.page++;
                    self.loadMedias();
                });
            } else {
                nextButton.css("opacity", 0.5);
            }

            $("#navigation").append(nextButton);            

            if (!Utils.isNullOrUndef(callback)) {
                callback();
            }

        }, "json");
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
    },

    setYear: function(year) {
        this.year = year;
    },

    _initializeMinimap: function() {
        var self = this;

        var mapbounds = new google.maps.LatLngBounds(
            new google.maps.LatLng(this.bounds.swlat, this.bounds.swlng),
            new google.maps.LatLng(this.bounds.nelat, this.bounds.nelng));

        //initialize map
        this.map = new google.maps.Map(document.getElementById("map"), {
            center: mapbounds.getCenter(),
            zoom: 5,
            scrollwheel: false,
            draggable: true,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            mapTypeControl: false,
            scaleControl: false,
            navigationControl: true,
            disableDoubleClickZoom: true
        });

        this.map.fitBounds(mapbounds);

        boundsQuad = new google.maps.Polygon({
            paths: [
                mapbounds.getSouthWest(),
                new google.maps.LatLng(mapbounds.getSouthWest().lat(), mapbounds.getNorthEast().lng()),
                mapbounds.getNorthEast(),
                new google.maps.LatLng(mapbounds.getNorthEast().lat(), mapbounds.getSouthWest().lng())
            ],
            strokeColor: "#8CC6FF",
            strokeOpacity: 0.6,
            strokeWeight: 2,
            fillColor: "#8CC6FF",
            fillOpacity: 0.2
        });

        boundsQuad.setMap(this.map);

        //initialization
        google.maps.event.addListener(this.map, "bounds_changed", function() {
            google.maps.event.clearListeners(self.map, "bounds_changed");
            //adjust zoom level after use of fitBounds
            //self.map.setZoom(self.map.getZoom() + 1);

            self._onMapReady();
        });
    },

    _initializeTimebar: function() {
        var self = this;
        this.timebar = new Timebar();

        this.timebar.initialize(this.year);
        this.timebar.setBounds(this.bounds);
        this.timebar.loadMedias();

        $(this.timebar).bind(Timebar.YEAR_CHANGED, function() {
            self.setYear(self.timebar.getYear());
            self.page = 1;
            self.loadMedias(function() {
                if (self.medias.length > 0) {
                    window.open("#show|id=" + self.medias[0].id, "_self");
                }
            });
        });
    },

    _onMapReady: function() {
        this._initializeTimebar();
    },

    _initializeNavigation: function() {
        var navigation = new AjaxNavigation();
        navigation.addAction("show", new ShowMediaAction(this));
        navigation.start();
    }
}