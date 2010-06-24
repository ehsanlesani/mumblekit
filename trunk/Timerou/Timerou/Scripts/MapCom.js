/*
Questo oggetto contiene solo metodi statici e serve per gestire la comunicazione con l'oggetto flash TimerouMap.
*/

function MapCom() { }

//instanza della mappa
MapCom.map = null;

//tipologie di mappa
MapCom.MAPTYPE_ROAD = "road";
MapCom.MAPTYPE_HYBRID = "hybrid";

//eventi
MapCom.NAVIGATION_MODE_SELECTED = "navigationModeSelected";
MapCom.MAP_READY = "mapReady";
MapCom.MAP_MOVE_END = "mapMoveEnd";

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

//cambia il tipo di mappa
MapCom.changeType = function(mapType) {
    MapCom.map.changeType(mapType);
};

//cerca un luogo sulla mappa, centrandolo se trovato
MapCom.searchLocation = function(key) {
    MapCom.map.searchLocation(key);
};

//imposta la mappa in modalita' sola lettura (quando viene aperto il dettaglio di un media)
MapCom.setLocationMode = function() {
    MapCom.map.setLocationMode();
};

//imposta la mappa in modalita' navigazione
MapCom.setNavigationMode = function() {
    MapCom.map.setNavigationMode();
};

//cancella il marker che indica la posizinoe del media corrente
MapCom.clearLocationMarker = function() {
    MapCom.map.clearLocationMarker();
};

//disegna un marker che mostra la posizione del media corrente
MapCom.markLocation = function(lat, lng) {
    MapCom.map.markLocation(lat, lng);
};

//events in flash map

//scatena un evento quando è selezionata la modalita' navigazione (utilizzato per nascondere il dettaglio nella main page)
MapCom.navigationModeSelected = function() {
    $(MapCom).trigger(MapCom.NAVIGATION_MODE_SELECTED);
};

//scatena un evetno quando la mappa è pronta
MapCom.onMapReady = function() {
    $(MapCom).trigger(MapCom.MAP_READY);
};

//scatena un evento quando è stata cambiata la posizione nella mappa (utilizzato per ricaricare i media da visualizzare sulla barra del tempo)
MapCom.onMapMoveEnd = function(swlat, swlng, nelat, nelng) {
    $(MapCom).trigger(MapCom.MAP_MOVE_END, {
        swlat: swlat,
        swlng: swlng,
        nelat: nelat,
        nelng: nelng
    });
};