/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Utils.js" />
/// <reference path="Url.js" />
/// <reference path="libs/google.maps-v3-vsdoc.js" />

function DetailManager(bounds, year) {
    this.map = null;
    this.bounds = Utils.stringToBounds(bounds);
    this.year = year;
    this.pageSize = 30;
    this.page = 1;
    this.medias = null;
    this.initialize();
    this.navigationInitialized = false;
    this.marker = null;
}

DetailManager.prototype = {
    initialize: function() {
        this._initializeMinimap();
        this._initializeTimebar();
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

            if (self.medias == null) {
                self.medias = [];
            }

            self.medias = self.medias.concat(response.medias);

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
        var mapbounds = new google.maps.LatLngBounds(
            new google.maps.LatLng(this.bounds.swlat, this.bounds.swlng),
            new google.maps.LatLng(this.bounds.nelat, this.bounds.nelng));

        //initialize map
        this.map = new google.maps.Map(document.getElementById("map"), {
            center: mapbounds.getCenter(),
            zoom: 5,
            scrollwheel: false,
            draggable: false,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            mapTypeControl: false,
            scaleControl: false,
            navigationControl: false,
            disableDoubleClickZoom: true
        });

        this.map.fitBounds(mapbounds);
    },

    _initializeTimebar: function() {
        var self = this;
        this.timebar = new Timebar();

        $(this.timebar).bind(Timebar.YEAR_CHANGED, function() {
            self.setYear(self.timebar.getYear());
        });

        //initialization
        google.maps.event.addListener(this.map, "bounds_changed", function() {
            google.maps.event.clearListeners(self.map, "bounds_changed");
            self.timebar.initialize(year);
            self.timebar.setBounds(Utils.googleBoundsToBounds(self.map.getBounds()));
            self.timebar.loadMedias();
            //adjust zoom level after use of fitBounds
            self.map.setZoom(self.map.getZoom() + 1);
        });
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