function AjaxNavigation() {
    this.index = 0;
}

AjaxNavigation.prototype = {
    goTo: function(url) {
        var self = this;
        $.post(BASEURL + "Location.aspx/Date", {}, function(result) { $("#date").html(result); window.open("#" + self.index++, "_self"); });
    }
}