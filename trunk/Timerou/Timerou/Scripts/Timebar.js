﻿/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Url.js" />
/// <reference path="Utils.js" />

function Timebar() {
    var self = this;

    this.yearsPositions = [];
    this.lastYear = new Date().getFullYear();
    this.firstYear = 0;
    this.minStepDistance = 75;
    this.year = new Date().getFullYear();
    this.stepDistance = 10;
    this.numberOfSteps = 1;
    this.stepMargin = this.minStepDistance / 2;
    this.currentStepsContainer = null;
    this.barWidth = 0;
    this.travelDuration = 1000;
    this.movementEnabled = true;
    this.mapMoveTimer = null;
    this.bounds = null;
}

Timebar.YEAR_CHANGED = "yearChanged";

Timebar.prototype = {
    initialize: function(year) {
        if (!Utils.isNullOrUndef(year)) { this.year = year; }

        this._setupInterface(true);
        this._resetStepsContainer();
        this._drawSteps(this.currentStepsContainer);
        this._drawYears(this.currentStepsContainer);
        this.setYear(this.year, true);

        this._setupEvents();
    },

    getYear: function() {
        return this.year;
    },

    setYear: function(year, forceReload) {
        if(Utils.isNullOrUndef(forceReload)) { forceReload = false; }
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
        if (!this.movementEnabled) { return; }

        var self = this;
        self._disableMoveButtons();
        var newStepsContainer = $("<div />").addClass("stepsContainer").css("left", this.barWidth * -1);
        $("#timebar .bar").append(newStepsContainer);
        this.lastYear = this.firstYear - 1;
        this.firstYear = this.lastYear - this.numberOfSteps;
        this._setupInterface();
        this._drawSteps(newStepsContainer);
        this._drawYears(newStepsContainer);
        var lastStepsContainer = this.currentStepsContainer;
        this.currentStepsContainer = newStepsContainer;
        $(newStepsContainer).animate({ left: "0px" }, this.travelDuration, "swing", function() { self._enableMoveButtons(); });
        $(lastStepsContainer).animate({ left: this.barWidth + "px" }, this.travelDuration, "swing", function() { $(lastStepsContainer).remove(); });
        this.setYear(this.year);
        this.loadPictures();
    },

    goForward: function() {
        if (!this.movementEnabled) { return; }

        var self = this;
        self._disableMoveButtons();
        var newStepsContainer = $("<div />").addClass("stepsContainer").css("left", this.barWidth);
        $("#timebar .bar").append(newStepsContainer);
        this.firstYear = this.lastYear + 1;
        this.lastYear = this.lastYear + this.numberOfSteps;
        this._setupInterface();
        this._drawSteps(newStepsContainer);
        this._drawYears(newStepsContainer);
        var lastStepsContainer = this.currentStepsContainer;
        this.currentStepsContainer = newStepsContainer;
        $(newStepsContainer).animate({ left: "0px" }, this.travelDuration, "swing", function() { self._enableMoveButtons(); });
        $(lastStepsContainer).animate({ left: this.barWidth * -1 + "px" }, this.travelDuration, "swing", function() { $(lastStepsContainer).remove(); });
        this.setYear(this.year);
        this.loadPictures();
    },

    setBounds: function(bounds) {
        this.bounds = bounds;
    },

    loadPictures: function() {
        if (Utils.isNullOrUndef(this.bounds)) {
            alert("loadPictures require mapBounds");
            return;
        }

        var bounds = this.bounds;

        var self = this;
        //clear all existent pictures
        this._clearPictures();

        $("#timebar .barLoading").show();
        $.post(Url.LoadOnePicturePerYear, {
            swlat: bounds.swlat,
            swlng: bounds.swlng,
            nelat: bounds.nelat,
            nelng: bounds.nelng,
            startYear: this.firstYear,
            stopYear: this.lastYear
        }, function(response) {
            $("#timebar .barLoading").hide();
            if (response.error) {
                alert(response.message);
                return;
            }

            self._renderPictures(response.groupedPictures);
        }, "json");
    },

    loadPicturesTimeSafe: function() {
        var self = this;

        if (self.mapMoveTimer != null) {
            window.clearTimeout(self.mapMoveTimer);
        }

        self.mapMoveTimer = window.setTimeout(function() { self.loadPictures(); }, 1000);
    },

    goToYear: function(year) {
        if (this.year == year) { return; }

        var self = this;
        var isGoingBack = this.year > year;
        var max = new Date().getFullYear();
        var mod = (max - year) % self.numberOfSteps;
        var newLastYear = year + mod;
        if (newLastYear != this.lastYear) {
            this.lastYear = newLastYear;
            this._disableMoveButtons();
            var left = this.barWidth;
            if (isGoingBack) {
                left *= -1;
            }
            var newStepsContainer = $("<div />").addClass("stepsContainer").css("left", left + "px");
            $("#timebar .bar").append(newStepsContainer);
            this._setupInterface();
            this._drawSteps(newStepsContainer);
            this._drawYears(newStepsContainer);
            var lastStepsContainer = this.currentStepsContainer;
            this.currentStepsContainer = newStepsContainer;
            $(newStepsContainer).animate({ left: "0px" }, this.travelDuration, "swing", function() { self._enableMoveButtons(); });
            $(lastStepsContainer).animate({ left: left * -1 + "px" }, this.travelDuration, "swing", function() { $(lastStepsContainer).remove(); });
            this.loadPicturesTimeSafe();
        }
        this.setYear(year);
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

        $(window).resize(function() {
            self._resetStepsContainer();
            self._clearPictures();
            self._setupInterface(self.currentStepsContainer);
            self._drawSteps(self.currentStepsContainer);
            self._drawYears(self.currentStepsContainer);
            self.loadPicturesTimeSafe();
            self.goToYear(self.year);
        });
    },

    _resetStepsContainer: function() {
        if (this.currentStepsContainer != null) {
            $(this.currentStepsContainer).remove();
        }
        this.currentStepsContainer = $("<div />").addClass("stepsContainer");
        $("#timebar .bar").append(this.currentStepsContainer);
    },

    _setupInterface: function(initialize) {
        this.yearPositions = [];

        //get bar width
        this.barWidth = $("#timebar .bar").width();
        this.numberOfSteps = parseInt(this.barWidth / this.minStepDistance);
        this.stepDistance = this.barWidth / (this.numberOfSteps - 1)
        this.numberOfSteps--;
        this.stepMargin = this.stepDistance / 2;

        if (!Utils.isNullOrUndef(initialize) && initialize) {
            var max = new Date().getFullYear();
            var mod = (max - this.year) % this.numberOfSteps;
            this.lastYear = this.year + mod;
        }
        this.firstYear = this.lastYear - this.numberOfSteps + 1;

        for (var i = 0; i < this.numberOfSteps; i++) {
            var x = this.stepMargin + (i * this.stepDistance)
            this.yearPositions.push({ year: this.firstYear + i, x: x });
        }
    },

    _drawSteps: function(stepsContainer) {
        var self = this;

        for (var i = 0; i < this.yearPositions.length; i++) {
            var yearPosition = this.yearPositions[i];

            var step = $("<div />")
                .addClass("step")
                .data("year", yearPosition.year);
            stepsContainer.append(step);
            //adjust step position
            var stepLeft = yearPosition.x - ($(step).width() / 2);
            $(step).css("left", stepLeft + "px");
        }
    },

    _drawYears: function(stepsContainer) {
        for (var i = 0; i < this.yearPositions.length; i++) {
            var yearPosition = this.yearPositions[i];

            var step = $("<div />").addClass("stepYear").html(yearPosition.year);
            stepsContainer.append(step);
            //adjust step position
            var stepLeft = yearPosition.x - ($(step).width() / 2);
            $(step).css("left", stepLeft + "px");
        }
    },

    _getYearPosition: function(year) {
        for (var i = 0; i < this.yearPositions.length; i++) {
            var yearPosition = this.yearPositions[i];
            if (yearPosition.year == year) { return yearPosition.x; }
        }

        return 0;
    },

    _clearPictures: function() {
        $("#timebar .picturesContainer .picture").slideUp(250, function() { $(this).remove(); });
    },

    _renderPictures: function(groupedPictures) {
        for (var i = 0; i < groupedPictures.length; i++) {
            var group = groupedPictures[i];
            //group.pictures is an array for a multi picture per year support
            var picture = this._renderPicture(group.pictures[0]);
            $("#timebar .picturesContainer").append(picture);
            //adjust position            
            $(picture).css("left", (this._getYearPosition(group.year) - $(picture).outerWidth() / 2) + "px").slideDown();
        }
    },

    _renderPicture: function(pictureData) {
        var self = this;
        return $("<img />")
            .attr("src", Url.Pictures + pictureData.avatarPath)
            .addClass("picture")
            .hide()
            .click(function() {
                self.setYear(pictureData.year);
            });
    }
};