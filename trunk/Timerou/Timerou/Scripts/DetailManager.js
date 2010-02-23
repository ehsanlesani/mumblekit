/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Utils.js" />
/// <reference path="Url.js" />
/// <reference path="libs/google.maps-v3-vsdoc.js" />

function DetailManager(bounds, year) {
    this.map = null;
    this.bounds = Utils.stringToBounds(bounds);
    this.year = year;

    this.initialize();
}

DetailManager.prototype = {
    initialize: function() {
        this.initializeMinimap();
    },

    initializeMinimap: function() {
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

        /*var bermudaTriangle = new google.maps.Polygon({
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

        bermudaTriangle.setMap(this.map);*/

    },

    setYear: function(year) {
        this.year = year;
    }
}