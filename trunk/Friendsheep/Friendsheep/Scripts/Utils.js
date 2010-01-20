function Utils() { };

Utils.isNullOrUndef = function(obj) {
    return obj == undefined || obj == null;
};

Utils.isNullOrEmpty = function (string) {
    return (string == undefined || string == null || string == "");
};

Utils.ajax = function (service, data, resultDiv, loadingDiv, callback) {
    if (!Utils.isNullOrUndef(loadingDiv)) { $(loadingDiv).fadeIn(250); }
    $.post(Url.AccountCulture,
            { culture: culture },
            function (result) {
                if (!Utils.isNullOrUndef(loadingDiv)) { $(loadingDiv).fadeOut(250); }
                if (!Utils.isNullOrUndef(resultDiv)) {
                    if (result.Error) {
                        $(resultDiv).removeClass("successbox");
                        $(resultDiv).addClass("errorbox");
                    } else {
                        $(resultDiv).removeClass("errorbox");
                        $(resultDiv).addClass("successbox");

                        if (!Utils.isNullOrUndef(callback)) {
                            callback(result);
                        }
                    }
                }
            },
            "json");
};