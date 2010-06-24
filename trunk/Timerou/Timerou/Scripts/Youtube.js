/*
Oggetto che gestisce i contenuti di youtube
*/

function Youtube() {
    this.id = null;
}

//qualita' dello screenshot restiuito. Utilizzabile come parametro del metodo getScreenshotUrl
Youtube.SMALL_SCREENSHOT = 2;
Youtube.MEDIUM_SCREENSHOT = 1;
Youtube.LARGE_SCREENSHOT = 0;

Youtube.prototype = {
    //inizializza l'oggetto tramite id del video youtube
    loadById: function(id) {
        this.id = id;
    },

    //inizializza l'oggetto tramite l'url del video youtube. L'url viene parserizzato per recuperare l'id
    loadByUrl: function(url) {
        var expression = /v=([^&]+)/i;
        var matches = url.match(expression);
        if (matches.length >= 2) {
            this.id = matches[1];
        }
        else {
            throw "badUrl";
        }
    },

    getId: function() {
        return this.id;
    },

    //restituisce lo screenshot del video specificato dall'id nella load
    getScreenshotUrl: function(size) {
        if (Utils.isNullOrUndef(this.id)) {
            throw "nullId";
        }
        return "http://img.youtube.com/vi/" + this.id + "/" + size + ".jpg";
    },

    //restituisce l'url per visualizzare il video da youtube
    getVideoUrl: function() {
        if (Utils.isNullOrUndef(this.id)) {
            throw "nullId";
        }
        return "http://www.youtube.com/watch?v=" + this.id + "/";
    },

    //crea un a html che visualizza la preview del video con id specificato nella load
    renderPreview: function() {
        var self = this;
        return $("<a />")
            .attr("href", "javascript:;")
            .click(function() {
                window.open(self.getVideoUrl());
            })
            .css({ position: "relative", height: "90px", width: "120px", display: "block" })
            .append($("<img />")
                .attr("src", this.getScreenshotUrl(Youtube.SMALL_SCREENSHOT))
            )
            .append($("<div />").addClass("videoIcon"));            
    }
};