function MapCom() { }

MapCom.MAPTYPE_ROAD = "road";
MapCom.MAPTYPE_HYBRID = "hybrid";
MapCom.map = null;

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

MapCom.setYear = function(year) {
    MapCom.map.setYear(year);
};

MapCom.searchLocation = function(key) {
    MapCom.map.searchLocation(key);
};

MapCom.getMapBounds = function() {
    var bounds = MapCom.map.getMapBounds();
    return bounds;
};

//events in flash map
MapCom.onMapReady = function() {
    $(MapCom).trigger("mapReady");
}

MapCom.onMapMoveEnd = function() {
    $(MapCom).trigger("mapMoveEnd");
}