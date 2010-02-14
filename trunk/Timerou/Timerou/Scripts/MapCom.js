function MapCom() { 
    this.map = $("embed[name='map']").get(0);
    if(this.map == undefined ||this.map == null) {
        var err = "Map not found";
        alert(err);
    }
}

MapCom.MAPTYPE_ROAD = "road";
MapCom.MAPTYPE_HYBRID = "hybrid";

MapCom.prototype = {
    changeType: function(mapType) {
        this.map.changeType(mapType);
    },

    setYear: function(year) {
        this.map.setYear(year);
    },

    searchLocation: function(key) {
        this.map.searchLocation(key);
    }
}