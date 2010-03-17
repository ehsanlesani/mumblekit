function Youtube() {
    this.id = null;
}

Youtube.SMALL_SCREENSHOT = 2;
Youtube.MEDIUM_SCREENSHOT = 1;
Youtube.LARGE_SCREENSHOT = 0;

Youtube.prototype = {
    loadById: function(id) {
        this.id = id;
    },

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

    getScreenshotUrl: function(size) {
        if (Utils.isNullOrUndef(this.id)) {
            throw "nullId";
        }
        return "http://img.youtube.com/vi/" + this.id + "/" + size + ".jpg";
    },

    getVideoUrl: function() {
        if (Utils.isNullOrUndef(this.id)) {
            throw "nullId";
        }
        return "http://www.youtube.com/watch?v=" + this.id + "/";
    },

    renderPreview: function() {
        var self = this;
        return $("<a />")
            .attr("href", "javascript:;")
            .click(function() {
                window.open(self.getVideoUrl());
            })
            .css({ position: "relative", height: "90px", width: "120px" })
            .append($("<img />")
                .attr("src", this.getScreenshotUrl(Youtube.SMALL_SCREENSHOT))
            )
            .append($("<img />")
                .attr("src", Url.Images + "videoIcon.png")
                .css({
                    position: "absolute",
                    right: "2px",
                    bottom: "2px"
                })
            );
    }
};