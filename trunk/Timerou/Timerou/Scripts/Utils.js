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
