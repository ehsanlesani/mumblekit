/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Utils.js" />
/// <reference path="Url.js" />
/// <reference path="libs/google.maps-v3-vsdoc.js" />

function DetailManager(bounds, year) {
    this.map = null;
    this.bounds = Utils.stringToBounds(bounds);
    this.year = year;
    this.pageSize = 15;
    this.page = 1;
    this.medias = null;
    this.marker = null;
    this.totalMedias = 0;

    this.initialize();
}

DetailManager.prototype = {
    initialize: function() {
        this._initializeTimebar();
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
                $("#navigation").append("<a href='#show|id=" + media.id + "'><img src='" + Url.Pictures + media.pictureData.avatarPath + "'/></a>");
            }

            if (!Utils.isNullOrUndef(callback)) {
                callback();
            }

        }, "json");
    },

    getMediaById: function(id, callback) {
        var self = this;
        if (this.medias == null) {
            this.loadMedias(function() {
                self.getMediaById(id, callback);
            });
            return;
        } else {
            for (var m in this.medias) {
                var media = this.medias[m];
                if (media.id == id) {
                    callback(media);
                    return;
                }
            }
        }

        callback(null);
    },

    displayMedia: function(id) {
        var self = this;

        this.getMediaById(id, function(media) {
            if (media == null) {
                Utils.showSiteError("Media is null");
                return;
            }

            if (media.type == "Picture") {
                $("#mediaContainer")
                    .empty()
                    .append($("<img />")
                        .attr("src", Url.Pictures + media.pictureData.optimizedPath)
                    );

                $("#title").html(media.title);
                $("#address").html(media.address);
                $("#body").html(media.body);

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

        bermudaTriangle = new google.maps.Polygon({
            paths: [
                mapbounds.getSouthWest(),
                mapbounds.getNorthEast()
            ],
            strokeColor: "#FF0000",
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: "#FF0000",
            fillOpacity: 0.35
        });

        bermudaTriangle.setMap(this.map);

        //initialization
        google.maps.event.addListener(this.map, "bounds_changed", function() {
            google.maps.event.clearListeners(self.map, "bounds_changed");
            //adjust zoom level after use of fitBounds
            self.map.setZoom(self.map.getZoom() + 1);

            self._onMapReady();
        });
    },

    _initializeTimebar: function() {
        var self = this;
        this.timebar = new Timebar();

        $(this.timebar).bind(Timebar.YEAR_CHANGED, function() {
            self.setYear(self.timebar.getYear());
            self.loadMedias(function() {
                if (self.medias.length > 0) {
                    window.open("#show|id=" + self.medias[0].id, "_self");
                }
            });

        });
    },

    _onMapReady: function() {
        this.timebar.initialize(this.year);
        this.timebar.setBounds(Utils.googleBoundsToBounds(this.map.getBounds()));
        this.timebar.loadMedias();
    },

    _initializeNavigation: function() {
        var navigation = new AjaxNavigation();
        navigation.addAction("show", new ShowMediaAction(this));
        navigation.start();
    },

    setYear: function(year) {
        this.year = year;
    }
}