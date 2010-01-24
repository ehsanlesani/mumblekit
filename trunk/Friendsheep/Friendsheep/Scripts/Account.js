/// <reference path="jquery-1.3.2.js" />
/// <reference path="Url.js" />

function Account() {}
Account.prototype = {
    register: function (data, resultDiv, loadingDiv) {
        if (loadingDiv != undefined) { $(loadingDiv).fadeIn(250); }
        $.post(Url.AccountRegister, data, function (result) {
            if (loadingDiv != undefined) { $(loadingDiv).fadeOut(250); }
            if (resultDiv != undefined) {
                if (result.error) {
                    $(resultDiv).removeClass("successbox");
                    $(resultDiv).addClass("errorbox");
                } else {
                    $(resultDiv).removeClass("errorbox");
                    $(resultDiv).addClass("successbox");

                    setTimeout(function () {
                        location.href = Url.Home;
                    }, 1000);
                }

                $(resultDiv).html(result.message);
            }
        }, "json");
    },

    changeCulture: function (culture) {
        $.post(Url.AccountCulture,
            { culture: culture },
            function (result) {
                if (result.error) {
                    alert(result.message);
                } else {
                    window.location.reload(true);
                }
            },
            "json");
    }
};