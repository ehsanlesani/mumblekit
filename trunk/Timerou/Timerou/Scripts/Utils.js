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
}

Utils.showInfo = function(message) {
    var actionBox = new ActionBox($("<p style='padding: 20px;'>" + message + "</p>"));
    actionBox.show();
    actionBox.center();
}
