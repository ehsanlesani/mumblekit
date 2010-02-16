/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
function Timebar() {
    this.lastYear = new Date().getFullYear();
    this.minStepDistance = 50;
    this.year = new Date().getFullYear();
    this.stepDistance = 10;
    this.numberOfSteps = 1;
    this.stepMargin = this.minStepDistance / 2;
}

Timebar.prototype = {
    initialize: function() {
        this.drawSteps();
        this.setYear(new Date().getFullYear());
    },

    drawSteps: function() {
        //get bar width
        var width = $("#timebar .bar").width();
        this.numberOfSteps = parseInt(width / this.minStepDistance);
        this.stepDistance = width / (this.numberOfSteps - 1)
        this.numberOfSteps--;
        this.stepMargin = this.stepDistance / 2;

        for (var i = 0; i < this.numberOfSteps; i++) {
            var step = $("<div />").addClass("step");
            $("#timebar .bar").append(step);
            //adjust step position
            var stepLeft = this.stepMargin + (i * this.stepDistance) - ($(step).width() / 2);
            $(step).css("left", stepLeft + "px");
        }
    },

    setYear: function(year) {
    this.year = year;
        
    }
};