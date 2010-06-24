/*
Questo oggetto contiene solo metodi statici e serve per gestire la comunicazione con l'oggetto flash TimeBar.
Contiene, al momento, metodi per settare e recuperare l'anno, in piu intercetta l'evento ON_MEDIA_CLICK, utilizzato nella main page per caricare il dettaglio dei media
*/

function TimebarCom() { }

TimebarCom.ON_MEDIA_CLICK = "mediaClick";
TimebarCom.timebar = null;

$(document).ready(function() {
    var movieName = "timebar";

    if (navigator.appName.indexOf("Microsoft") != -1) {
        TimebarCom.timebar = window[movieName];
    } else {
    TimebarCom.timebar = document[movieName];
    }

    if (TimebarCom.timebar == undefined || TimebarCom.timebar == null) {
        var err = "Timebar not found";
        alert(err);
    }
});

TimebarCom.setYear = function(year) {
    TimebarCom.timebar.setYear(year);
};

TimebarCom.getYear = function() {
    return TimebarCom.timebar.getYear();
};

//events in flash timebar
TimebarCom.onMediaClick = function(id) {
    $(TimebarCom).trigger(TimebarCom.ON_MEDIA_CLICK, id);
};


