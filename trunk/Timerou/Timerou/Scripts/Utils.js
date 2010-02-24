/// <reference path="ActionBox.js" />

function Utils() { };

Utils.isNullOrUndef = function(obj) {
    return obj == undefined || obj == null;
};

Utils.isNullOrEmpty = function (string) {
    return (string == undefined || string == null || string == "");
};

Utils.trace = function(string) {
    if (window.console) {
        window.console.log(string);
    }
};

Utils.showInfo = function(message) {
    var actionBox = new ActionBox($("<p style='padding: 20px;'>" + message + "</p>"));
    actionBox.show();
    actionBox.center();
};

Utils.boundsToString = function(bounds, precision) {
    var swlat = bounds.swlat;
    var swlng = bounds.swlng;
    var nelat = bounds.nelat;
    var nelng = bounds.nelng;
    
    if(!Utils.isNullOrUndef(precision)) {
        var multiplier = Math.pow(10, precision);
        swlat = Math.round(swlat * multiplier) / multiplier;
        swlng = Math.round(swlng * multiplier) / multiplier;
        nelat = Math.round(nelat * multiplier) / multiplier;
        nelng = Math.round(nelng * multiplier) / multiplier;
    }
    
    return swlat + "," + swlng + "," + nelat + "," + nelng;
};

Utils.stringToBounds = function(string) {
    var split = string.split(",");
    return { swlat: split[0], swlng: split[1], nelat: split[2], nelng: split[3] };
};

Utils.googleBoundsToBounds = function(googleBounds) {
    return {
        swlat: googleBounds.getSouthWest().lat(),
        swlng: googleBounds.getSouthWest().lng(),
        nelat: googleBounds.getNorthEast().lat(),
        nelng: googleBounds.getNorthEast().lng()
    };
};

Utils.showSiteError = function(error) {
    alert("SITE ERROR: " + error);
};