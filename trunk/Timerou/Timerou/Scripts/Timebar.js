/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Url.js" />
/// <reference path="Utils.js" />

function Timebar() {
    var self = this;

    this.yearsPositions = [];
    this.lastYear = new Date().getFullYear();
    this.firstYear = 0;
    this.mediaWidth = 75;
    this.slotWidth = 75;
    this.year = new Date().getFullYear();
    this.numberOfSteps = 1;
    this.stepMargin = this.mediaWidth / 2;
    this.currentStepsContainer = null;
    this.barWidth = 0;
    this.travelDuration = 1000;
    this.movementEnabled = true;
    this.mapMoveTimer = null;
    this.bounds = null;
    this.loadedMedias = [];
    this.renderMedias = [];
}

Timebar.YEAR_CHANGED = "yearChanged";

Timebar.prototype = {
    initialize: function(year) {
        if (!Utils.isNullOrUndef(year)) { this.year = year; }
        this._calculateMaxNumberOfSteps();
        this._setupEvents();
    },

    getYear: function() {
        return this.year;
    },

    setYear: function(year, forceReload) {
        if (Utils.isNullOrUndef(forceReload)) { forceReload = false; }
        if (this.year == year && !forceReload) { return; }

        this.year = year;
        $(this).trigger(Timebar.YEAR_CHANGED);

        if (year >= this.firstYear && year <= this.lastYear) {
            $("#timebar .bar .pointer:hidden").fadeIn(250);
            var x = this._getYearPosition(year) - $("#timebar .bar .pointer").width() / 2;
            $("#timebar .bar .pointer").animate({ "left": x + "px" });
        } else {
            $("#timebar .bar .pointer:visible").fadeOut(250);
        }
    },

    goBack: function() {

    },

    goForward: function() {

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
        this.renderMedias = [];

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
            slots: this.numberOfSteps,
            lastYear: this.lastYear
        }, function(response) {
            $("#timebar .barLoading").hide();
            if (response.error) {
                Utils.showSiteError(response.message);
                return;
            }

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

    _calculateMaxNumberOfSteps: function() {
        //get bar width
        this.barWidth = $("#timebar .bar").width();
        this.numberOfSteps = parseInt(this.barWidth / this.mediaWidth);
    },

    _setupInterface: function() {
        this.yearPositions = [];
        this._calculateMaxNumberOfSteps();

        //find minimum years distance
        var minYearsDistance = 999999999;
        for (var i = 0; i < this.loadedMedias.length - 1; i++) {
            var currentYearsDistance = this.loadedMedias[i + 1].year - this.loadedMedias[i].year;
            minYearsDistance = Math.min(minYearsDistance, currentYearsDistance);
        }
        var minYearThatCanBe = this.lastYear - (minYearsDistance * this.numberOfSteps);
        //find first allowed year
        this.firstYear = 99999999;
        this.lastYear = 0;
        for (var i = 0; i < this.loadedMedias.length; i++) {
            if (this.loadedMedias[i].year >= minYearThatCanBe) {
                this.renderMedias.push(this.loadedMedias[i]);
                this.firstYear = Math.min(this.firstYear, this.loadedMedias[i].year);
                this.lastYear = Math.max(this.lastYear, this.loadedMedias[i].year);
            }
        }
        //calculate positions
        var workWidth = this.barWidth - this.mediaWidth;
        var yearsDelta = this.lastYear - this.firstYear;
        for (var i = 0; i < this.renderMedias.length; i++) {
            var delta = yearsDelta - (this.lastYear - this.renderMedias[i].year);
            var x = workWidth * delta / yearsDelta + this.mediaWidth / 2;
            this.yearsPositions.push({ year: this.firstYear + delta, x: x });
        }
    },

    _drawSteps: function(stepsContainer) {
        var self = this;

        for (var i = 0; i < this.renderMedias.length; i++) {
            var renderMedia = this.renderMedias[i];
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
        for (var i = 0; i < this.renderMedias.length; i++) {
            var renderMedia = this.renderMedias[i];
            var yearPosition = this._getYearPosition(renderMedia.year);

            var step = $("<div />").addClass("stepYear").html(renderMedia.year);
            stepsContainer.append(step);
            //adjust step position
            var stepLeft = yearPosition - ($(step).width() / 2);
            $(step).css("left", stepLeft + "px");
        }
    },

    _getYearPosition: function(year) {
        for (var i = 0; i < this.yearsPositions.length; i++) {
            var yearPosition = this.yearsPositions[i];
            if (yearPosition.year == year) { return yearPosition.x; }
        }

        return 0;
    },

    _clearMedias: function() {
        $("#timebar .mediasContainer .picture").slideUp(250, function() { $(this).remove(); });
    },

    _renderMedias: function() {
        for (var i = 0; i < this.renderMedias.length; i++) {
            var group = this.renderMedias[i];
            //group.medias is an array for a multi picture per year support
            var media = this._renderMedia(group.medias[0]);
            $("#timebar .mediasContainer").append(media);
            //adjust position
            $(media).css("left", (this._getYearPosition(group.year) - $(media).outerWidth() / 2) + "px").slideDown();
        }

        this._resetStepsContainer();
        this._drawSteps(this.currentStepsContainer);
        this._drawYears(this.currentStepsContainer);
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