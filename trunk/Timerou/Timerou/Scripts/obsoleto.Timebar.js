/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Url.js" />
/// <reference path="Utils.js" />

function Timebar() {
    var self = this;

    this.yearsPositions = [];
    this.referenceYear = new Date().getFullYear();
    this.direction = Timebar.DIRECTION_BACK;
    this.mediaWidth = 75;
    this.year = null;
    this.mediasToLoad = 1; //the number of medias that can be loaded
    this.currentStepsContainer = null;
    this.barWidth = 0;
    this.travelDuration = 1000;
    this.movementEnabled = true;
    this.mapMoveTimer = null;
    this.bounds = null;
    this.loadedMedias = []; //the loaded medias

    //response
    this.minYear = 0;
    this.maxYear = 0;
    this.hasMediasBefore = false;
    this.hasMediasAfter = false;
}

Timebar.YEAR_CHANGED = "yearChanged";
Timebar.DIRECTION_BACK = "Back";
Timebar.DIRECTION_FORWARD = "Forward";

Timebar.prototype = {
    initialize: function(year) {
        if (!Utils.isNullOrUndef(year)) { this.year = year; }
        this._calculateMediasToLoad();
        this._setupEvents();
    },

    getYear: function() {
        return this.year;
    },

    setYear: function(year, forceReload, trigger) {
        if (Utils.isNullOrUndef(forceReload)) { forceReload = false; }
        if (Utils.isNullOrUndef(trigger)) { trigger = true; }
        if (this.year == year && !forceReload) { return; }

        this.year = year;
        if (trigger) { $(this).trigger(Timebar.YEAR_CHANGED); }
        this._movePointerToCurrentYear();
    },

    goBack: function() {
        if (this.hasMediasBefore) {
            this.hasMediasBefore = false; //prevent rapid clicks
            this._resetStepsContainer();
            this.referenceYear = this.minYear;
            this.direction = Timebar.DIRECTION_BACK;
            this.loadMedias();
        }
    },

    goForward: function() {
        if (this.hasMediasAfter) {
            this.hasMediasAfter = false; //prevent rapid clicks
            this._resetStepsContainer();
            this.referenceYear = this.maxYear;
            this.direction = Timebar.DIRECTION_FORWARD;
            this.loadMedias();
        }
    },

    setBounds: function(bounds) {
        this.bounds = bounds;
    },

    loadMedias: function() {
        if (Utils.isNullOrUndef(this.bounds)) {
            alert("loadMedias require mapBounds");
            return;
        }

        this.loadedMedias = [];

        var bounds = this.bounds;

        var self = this;
        //clear all existent Media
        this._clearMedias();

        $("#timebar .barLoading").show();
        $.post(Url.LoadOneMediaPerYear, {
            swlat: bounds.swlat,
            swlng: bounds.swlng,
            nelat: bounds.nelat,
            nelng: bounds.nelng,
            mediasToLoad: this.mediasToLoad,
            referenceYear: this.referenceYear,
            direction: this.direction
        }, function(response) {
            $("#timebar .barLoading").hide();
            if (response.error) {
                Utils.showSiteError(response.message);
                return;
            }

            self.minYear = response.minYear;
            self.maxYear = response.maxYear;
            self.hasMediasBefore = response.hasMediasBefore;
            self.hasMediasAfter = response.hasMediasAfter;
            self.loadedMedias = response.groupedMedias;
            self._setupInterface();
            self._renderMedias();
        }, "json");
    },

    loadMediasTimeSafe: function() {
        var self = this;

        if (self.mapMoveTimer != null) {
            window.clearTimeout(self.mapMoveTimer);
        }

        self.mapMoveTimer = window.setTimeout(function() { self.loadMedias(); }, 1000);
    },

    _movePointerToCurrentYear: function() {
        var yearPosition = this._findYearPositionObject(this.year);
        if (yearPosition != null) {
            $("#timebar .bar .pointer:hidden").fadeIn(250);
            var x = yearPosition.x - $("#timebar .bar .pointer").width() / 2;
            $("#timebar .bar .pointer").animate({ "left": x + "px" });
        } else {
            $("#timebar .bar .pointer:visible").fadeOut(250);
        }
    },

    _disableMoveButtons: function() {
        this.movementEnabled = false;
        $("#timebar .backButton, #timebar .forwardButton").attr("onclick", "return false;").fadeTo(250, 0.5);
    },

    _enableMoveButtons: function() {
        this.movementEnabled = true;
        $("#timebar .backButton, #timebar .forwardButton").removeAttr("onclick").fadeTo(250, 1);
    },

    _setupEvents: function() {
        var self = this;

        $("#timebar .backButton").click(function() { self.goBack(); });
        $("#timebar .forwardButton").click(function() { self.goForward(); });

        /*$(window).resize(function() {
        self._resetStepsContainer();
        self._clearMedias();
        self._setupInterface(self.currentStepsContainer);
        self._drawSteps(self.currentStepsContainer);
        self._drawYears(self.currentStepsContainer);
        self.loadMediasTimeSafe();
        self.goToYear(self.year);
        });*/
    },

    _resetStepsContainer: function() {
        if (this.currentStepsContainer != null) {
            $(this.currentStepsContainer).remove();
        }
        this.currentStepsContainer = $("<div />").addClass("stepsContainer");
        $("#timebar .bar").append(this.currentStepsContainer);
    },

    _calculateMediasToLoad: function() {
        //get bar width
        this.barWidth = $("#timebar .bar").width();
        this.mediasToLoad = parseInt(this.barWidth / this.mediaWidth);
    },

    _setupInterface: function() {
        this.yearsPositions = [];
        this._calculateMediasToLoad(); //to get bar width

        if (this.loadedMedias.length == 1) {
            this.yearsPositions.push({ year: this.minYear, x: this.barWidth / 2 });
        } else {
            //calculate positions
            var workWidth = this.barWidth - this.mediaWidth;
            var yearsDelta = this.maxYear - this.minYear;
            for (var i = 0; i < this.loadedMedias.length; i++) {
                var delta = yearsDelta - (this.maxYear - this.loadedMedias[i].year);
                var x = workWidth * delta / yearsDelta + this.mediaWidth / 2;
                this.yearsPositions.push({ year: this.minYear + delta, x: x });
            }
        }

        this._movePointerToCurrentYear();
    },

    _drawSteps: function(stepsContainer) {
        var self = this;

        for (var i = 0; i < this.loadedMedias.length; i++) {
            var renderMedia = this.loadedMedias[i];
            var yearPosition = this._getYearPosition(renderMedia.year);

            var step = $("<div />")
                .addClass("step")
                .data("year", renderMedia.year);
            stepsContainer.append(step);
            //adjust step position
            var stepLeft = yearPosition - ($(step).width() / 2);
            $(step).css("left", stepLeft + "px");
        }
    },

    _drawYears: function(stepsContainer) {
        for (var i = 0; i < this.loadedMedias.length; i++) {
            var renderMedia = this.loadedMedias[i];
            var yearPosition = this._getYearPosition(renderMedia.year);

            var step = $("<div />").addClass("stepYear").html(renderMedia.year);
            stepsContainer.append(step);
            //adjust step position
            var stepLeft = yearPosition - ($(step).width() / 2);
            $(step).css("left", stepLeft + "px");
        }
    },

    _findYearPositionObject: function(year) {
        for (var i = 0; i < this.yearsPositions.length; i++) {
            var yearPosition = this.yearsPositions[i];
            if (yearPosition.year == year) { return yearPosition; }
        }

        return null;
    },

    _getYearPosition: function(year) {
        var obj = this._findYearPositionObject(year);
        if (obj != null) { return obj.x; }
        else { return 0; }
    },

    _clearMedias: function() {
        $("#timebar .mediasContainer .picture").slideUp(250, function() { $(this).remove(); });
    },

    _renderMedias: function() {
        for (var i = 0; i < this.loadedMedias.length; i++) {
            var group = this.loadedMedias[i];
            //group.medias is an array for a multi picture per year support
            var media = this._renderMedia(group.medias[0]);
            $("#timebar .mediasContainer").append(media);
            //adjust position
            var x = (this._getYearPosition(group.year) - $(media).outerWidth() / 2);
            if (this.direction == Timebar.DIRECTION_BACK) {
                $(media).css("left", (this.mediaWidth * -1) + "px").show();
            } else {
                $(media).css("left", (this.mediaWidth + this.barWidth) + "px").show();
            }
            //animate to position
            $(media).animate({ left: x + "px" }, this.travelDuration, "swing");
        }

        this._resetStepsContainer();
        this._drawSteps(this.currentStepsContainer);
        this._drawYears(this.currentStepsContainer);

        //check move buttons
        if (this.hasMediasBefore) {
            $("#timebar .backButton:hidden").fadeIn(250);
        } else {
            $("#timebar .backButton:visible").fadeOut(250);
        }

        if (this.hasMediasAfter) {
            $("#timebar .forwardButton:hidden").fadeIn(250);
        } else {
            $("#timebar .forwardButton:visible").fadeOut(250);
        }
    },

    _renderMedia: function(mediaData) {
        var self = this;
        if (mediaData.type == "Picture") {
            return $("<img />")
                .attr("src", Url.Pictures + mediaData.pictureData.avatarPath)
                .addClass("picture")
                .hide()
                .click(function() {
                    self.setYear(mediaData.year);
                });
        }
        else {
            alert("Video renderer not implemented");
            return $("<p>not implemented</p>");
        }
    }
};