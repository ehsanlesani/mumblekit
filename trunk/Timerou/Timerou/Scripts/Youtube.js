function Youtube() {
    this.id = null;
}

Youtube.prototype = {
    loadById: function(id) {

    },

    loadByUrl: function(url) {
        var expression = /v=(?<id>[^&]+)/i;
        Utils.trace(url.match(expression));
    }

};