/// <reference path="Utils.js" />
/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Url.js" />

function MediaNavigator() {
    this.size = 70;
    this.margin = 5;
    this.effectiveMargin = 5;
    this.year = new Date().getFullYear();
    this.bounds = null;
    this.loadTimer = null;
    this.page = 1;
    this.pageSize = 100;
    this.totalCount = 0;
    this.rows = 10;
    this.columns = 10;
    this.correctMarginX = 5;
    this.correctMarginY = 5;
}

MediaNavigator.MEDIA_HOVER = "mediaHover";
MediaNavigator.MEDIA_OUT = "mediaOut";
MediaNavigator.MEDIA_CLICK = "mediaClick";
MediaNavigator.MEDIAS_LOADED = "mediasLoaded";

MediaNavigator.prototype = {
    initialize: function(year) {
        var self = this;
        this.year = year;

        $(window).resize(function() {
            self._setupInterface();
            self.loadMediasTimeSafe();
        });

        this._setupInterface();
    },

    setBounds: function(bounds) {
        this.bounds = bounds;
    },

    setYear: function(year) {
        this.year = year;
    },

    loadMedias: function() {
        if (Utils.isNullOrUndef(this.bounds)) {
            alert("loadMedias require mapBounds");
            return;
        }

        var bounds = this.bounds;

        var self = this;
        //clear all existent Media
        this._clearMedias();

        //$("#timebar .barLoading").show();
        $.post(Url.LoadMedias, {
            swlat: bounds.swlat,
            swlng: bounds.swlng,
            nelat: bounds.nelat,
            nelng: bounds.nelng,
            year: this.year,
            page: this.page,
            pageSize: this.pageSize
        }, function(response) {
            //$("#timebar .barLoading").hide();
            if (response.error) {
                Utils.showSiteError(response.message);
                return;
            }

            $(self).trigger(MediaNavigator.MEDIAS_LOADED, [response.medias]);

            self.totalCount = response.totalCount;
            self._renderMedias(response.medias);
        }, "json");
    },

    loadMediasTimeSafe: function() {
        var self = this;

        if (self.loadTimer != null) {
            window.clearTimeout(self.loadTimer);
        }

        self.loadTimer = window.setTimeout(function() { self.loadMedias(); }, 1000);
    },

    _renderMedias: function(medias) {
        var row = 0;
        var col = 0;

        var counter = 0;

        for (var i = 0; i < medias.length; i++) {
            var mediaData = medias[i];
            var media = this._renderMedia(mediaData);
            $("#mapMediasContainer").append(media);
            //adjust position
            $(media).css({
                "position": "absolute",
                "left": this.margin + (col * this.correctMarginX) + (col * this.size),
                "top": this.margin + (row * this.correctMarginY) + (row * this.size)
            });

            col++;
            if (col >= this.columns) {
                col = 0;
                row++;
            }

            counter++;
        }

        for (var i = counter + 1; i <= this.pageSize; i++) {
            $("#mapMediasContainer").append($("<div />")
                .addClass("whiteSpace")
                .css({
                    "position": "absolute",
                    "left": this.margin + (col * this.correctMarginX) + (col * this.size),
                    "top": this.margin + (row * this.correctMarginY) + (row * this.size)
                })
            );

            col++;
            if (col >= this.columns) {
                col = 0;
                row++;
            }
        }

        $("#mapMediasContainer").append($("<a />")
                .attr("href", "javascript:;")
                .addClass("media")
                .append($("<img />")
                    .attr("src", Url.Images + "previousPage.png")
                )
                .hover(function() { }, function() { })
                .click(function() { })
                .css({
                    "position": "absolute",
                    "left": this.margin + (col * this.correctMarginX) + (col * this.size),
                    "top": this.margin + (row * this.correctMarginY) + (row * this.size)
                })
            );

        col++;

        $("#mapMediasContainer").append($("<a />")
                .attr("href", "javascript:;")
                .addClass("media")
                .append($("<img />")
                    .attr("src", Url.Images + "nextPage.png")
                )
                .hover(function() { }, function() { })
                .click(function() { })
                .css({
                    "position": "absolute",
                    "left": this.margin + (col * this.correctMarginX) + (col * this.size),
                    "top": this.margin + (row * this.correctMarginY) + (row * this.size)
                })
            );
    },

    _renderMedia: function(mediaData) {
        var self = this;
        if (mediaData.type == "Picture") {
            return $("<a />")
                .attr("href", "javascript:;")
                .addClass("media")
                .append($("<img />")
                    .attr("src", Url.Pictures + mediaData.pictureData.avatarPath)
                )
                .hover(function() { $(self).trigger(MediaNavigator.MEDIA_HOVER, mediaData); }, function() { $(self).trigger(MediaNavigator.MEDIA_OUT, mediaData) })
                .click(function() { $(self).trigger(MediaNavigator.MEDIA_CLICK, mediaData); });
        }
        else {
            var youtube = new Youtube();
            youtube.loadById(mediaData.videoData.youtubeId);
            return $("<a />")
                .attr("href", "javascript:;")
                .addClass("media")
                .append($("<img />")
                    .attr("src", youtube.getScreenshotUrl(Youtube.SMALL_SCREENSHOT))
                )
                .append($("<div />").addClass("videoIcon"))
                .hover(function() { $(self).trigger(MediaNavigator.MEDIA_HOVER, mediaData); }, function() { $(self).trigger(MediaNavigator.MEDIA_OUT, mediaData) })
                .click(function() { $(self).trigger(MediaNavigator.MEDIA_CLICK, mediaData); });
        }
    },

    _clearMedias: function() {
        $("#mapMediasContainer").empty();
    },

    _setupInterface: function() {
        var width = $("#mapMediasContainer").width() - this.margin * 3;
        var height = $("#mapMediasContainer").height() - this.margin * 3;
        var mediaSizeWithMargin = this.size + this.margin;
        this.columns = parseInt(width / mediaSizeWithMargin);
        this.rows = parseInt(height / mediaSizeWithMargin);
        this.pageSize = this.columns * this.rows - 2;

        var totalWidth = (this.columns * this.size);
        var deltaX = width - totalWidth;
        this.correctMarginX = deltaX / (this.columns - 1);

        var totalHeight = (this.rows * this.size);
        var deltaY = height - totalHeight;
        this.correctMarginY = deltaY / (this.rows - 1);
    }
};