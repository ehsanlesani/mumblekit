function MapCom() { }

MapCom.MAPTYPE_ROAD = "road";
MapCom.MAPTYPE_HYBRID = "hybrid";
MapCom.map = null;

MapCom.NAVIGATION_MODE_SELECTED = "navigationModeSelected";
MapCom.MAP_READY = "mapReady";

$(document).ready(function() {
    var movieName = "map";

    if (navigator.appName.indexOf("Microsoft") != -1) {
        MapCom.map = window[movieName];
    } else {
        MapCom.map = document[movieName];
    }

    if (MapCom.map == undefined || MapCom.map == null) {
        var err = "Map not found";
        alert(err);
    }
});

MapCom.changeType = function(mapType) {
    MapCom.map.changeType(mapType);
};

MapCom.searchLocation = function(key) {
    MapCom.map.searchLocation(key);
};

MapCom.setLocationMode = function() {
    MapCom.map.setLocationMode();
};

MapCom.setNavigationMode = function() {
    MapCom.map.setNavigationMode();
};

MapCom.clearLocationMarker = function() {
    MapCom.map.clearLocationMarker();
};

MapCom.markLocation = function(lat, lng) {
    MapCom.map.markLocation(lat, lng);
};

//events in flash map
MapCom.navigationModeSelected = function() {
    $(MapCom).trigger(MapCom.NAVIGATION_MODE_SELECTED);
};

MapCom.onMapReady = function() {
    $(MapCom).trigger(MapCom.MAP_READY);
};