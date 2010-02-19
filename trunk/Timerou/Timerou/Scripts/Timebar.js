/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Url.js" />
/// <reference path="MapCom.js" />
/// <reference path="Utils.js" />

function Timebar(mapCom) {
    var self = this;

    this.mapCom = mapCom;
    this.yearsPositions = [];
    this.lastYear = new Date().getFullYear();
    this.firstYear = 0;
    this.minStepDistance = 50;
    this.year = new Date().getFullYear();
    this.stepDistance = 10;
    this.numberOfSteps = 1;
    this.stepMargin = this.minStepDistance / 2;
    this.currentStepsContainer = null;
    this.barWidth = 0;
    this.travelDuration = 1000;
    this.movementEnabled = true;
    this.mapMoveTimer = null;

    $(MapCom).bind("mapReady", function() {
        self.initialize();
        self.loadPictures();
    });
}

Timebar.prototype = {
    initialize: function() {
        this._setupInterface();
        this._resetStepsContainer();
        this._drawSteps(this.currentStepsContainer);
        this._drawYears(this.currentStepsContainer);
        this.setYear(new Date().getFullYear());

        this._setupEvents();
    },

    setYear: function(year) {
        this.year = year;
        var x = this._getYearPosition(year) - $("#timebar .bar .pointer").width() / 2;
        MapCom.setYear(year);
        $("#timebar .bar .pointer").animate({ "left": x + "px" });
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
        this.loadPictures();
    },

    loadPictures: function() {
        var bounds = MapCom.getMapBounds();

        var self = this;
        //clear all existent pictures
        this._clearPictures();

        $("#timebar .barLoading").show();
        $.post(Url.LoadOnePicturePerYear, {
            lat1: bounds.lat1,
            lng1: bounds.lng1,
            lat2: bounds.lat2,
            lng2: bounds.lng2,
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
    
    centerYear: function(year) {
    
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

        $(MapCom).bind("mapMoveEnd", function() {
            self.loadPicturesTimeSafe();
        });

        $(window).resize(function() {
            self._resetStepsContainer();
            self._clearPictures();
            self._setupInterface(self.currentStepsContainer);
            self._drawSteps(self.currentStepsContainer);
            self._drawYears(self.currentStepsContainer);
            self.loadPicturesTimeSafe();
            self.centerYear(self.year);
            self.setYear(self.year);
        });
    },

    _resetStepsContainer: function() {
        if (this.currentStepsContainer != null) {
            $(this.currentStepsContainer).remove();
        }
        this.currentStepsContainer = $("<div />").addClass("stepsContainer");
        $("#timebar .bar").append(this.currentStepsContainer);
    },

    _setupInterface: function() {
        this.yearPositions = [];

        //get bar width
        this.barWidth = $("#timebar .bar").width();
        this.numberOfSteps = parseInt(this.barWidth / this.minStepDistance);
        this.stepDistance = this.barWidth / (this.numberOfSteps - 1)
        this.numberOfSteps--;
        this.stepMargin = this.stepDistance / 2;

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