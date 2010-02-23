/// <reference path="libs/google.maps-v3-vsdoc.js" />
function MapCom() { }

MapCom.MAPTYPE_ROAD = "road";
MapCom.MAPTYPE_HYBRID = "hybrid";
MapCom.map = null;

MapCom.setMap = function(map) {
    MapCom.map = map;
    google.maps.event.addListener(MapCom.map, "bounds_changed", function() {
        google.maps.event.clearListeners(MapCom.map, "bounds_changed");
        $(MapCom).trigger("mapReady");
    });
}

MapCom.changeType = function(mapType) {
    
};

MapCom.setYear = function(year) {
    
};

MapCom.searchLocation = function(key) {
    
};

MapCom.getMapBounds = function() {
    var bounds = {};
    bounds.swlat = this.map.getBounds().getSouthWest().lat();
    bounds.swlng = this.map.getBounds().getSouthWest().lng();
    bounds.nelat = this.map.getBounds().getNorthEast().lat();
    bounds.nelng = this.map.getBounds().getNorthEast().lng();
    return bounds;
};
