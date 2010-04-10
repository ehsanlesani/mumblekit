/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="libs/fx.js" />

function MapMediaTransition(mapContainer, mediaContainer) {
    this.duration = 250;
    this.delay = 10;
    this.mapMinimizedSize = { width: 331, height: 300 };
    this.mapMaximizedSize = { width: 981, height: 500 };
    
    this.mapContainer = mapContainer;
    this.mediaContainer = mediaContainer;
}

MapMediaTransition.prototype = {
    maximizeMap: function() {
        var steps = this.duration / this.delay;
        var deltaHeight = Math.abs($(this.mapContainer).height() - this.mapMaximizedSize.height);
        var deltaWidth = Math.abs($(this.mapContainer).width() - this.mapMaximizedSize.width);
        var stepHeight = deltaHeight / steps;
        var stepWidth = deltaWidth / steps;

        $fx($(this.mapContainer).get(0)).fxAdd({ type: "height", to: this.mapMaximizedSize.height, step: stepHeight, delay: this.delay }).fxRun();
        $fx($(this.mapContainer).get(0)).fxAdd({ type: "width", to: this.mapMaximizedSize.width, step: stepWidth, delay: this.delay }).fxRun();
    },

    minimizeMap: function() {
        var steps = this.duration / this.delay;
        var deltaHeight = Math.abs($(this.mapContainer).height() - this.mapMinimizedSize.height);
        var deltaWidth = Math.abs($(this.mapContainer).width() - this.mapMinimizedSize.width);
        var stepHeight = deltaHeight / steps * -1;
        var stepWidth = deltaWidth / steps * -1;

        $fx($(this.mapContainer).get(0)).fxAdd({ type: "height", to: this.mapMinimizedSize.height, step: stepHeight, delay: this.delay }).fxRun();
        $fx($(this.mapContainer).get(0)).fxAdd({ type: "width", to: this.mapMinimizedSize.width, step: stepWidth, delay: this.delay }).fxRun();
    }
};