/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="libs/fx.js" />

function MapMediaTransition(mapContainer, mediaContainer) {
    this.duration = 300;
    this.delay = 30;
    this.mapMinimizedSize = { width: 323, height: 300 };
    this.mapMaximizedSize = { width: 680, height: 500 };
    
    this.mapContainer = mapContainer;
    this.mediaContainer = mediaContainer;
    
    this.viewMode = MapMediaTransition.VIEW_MAP;
}

MapMediaTransition.VIEW_MAP = "map";
MapMediaTransition.VIEW_DETAILS = "details";

MapMediaTransition.prototype = {
    maximizeMap: function() {
        if (this.viewMode == MapMediaTransition.VIEW_MAP) { return; }
        this.viewMode = MapMediaTransition.VIEW_MAP;
        MapCom.setNavigationMode();

        var steps = this.duration / this.delay;
        var deltaHeight = Math.abs($(this.mapContainer).height() - this.mapMaximizedSize.height);
        var deltaWidth = Math.abs($(this.mapContainer).width() - this.mapMaximizedSize.width);
        var stepHeight = deltaHeight / steps;
        var stepWidth = deltaWidth / steps;

        //$('#comments').hide();
        //$('#titleBar').hide();        
        $fx($(this.mediaContainer).get(0)).fxAdd({ type: "marginLeft", to: 981, step: stepWidth, delay: this.delay }).fxRun();
        $fx($(this.mapContainer).get(0)).fxAdd({ type: "height", to: this.mapMaximizedSize.height, step: stepHeight, delay: this.delay }).fxRun();
        $fx($(this.mapContainer).get(0)).fxAdd({ type: "width", to: this.mapMaximizedSize.width, step: stepWidth, delay: this.delay }).fxRun();
        $('#navigator').show();
    },

    minimizeMap: function() {
        if (this.viewMode == MapMediaTransition.VIEW_DETAILS) { return; }

        $('#navigator').hide();
        this.viewMode = MapMediaTransition.VIEW_DETAILS;
        MapCom.setLocationMode();

        var steps = this.duration / this.delay;
        var deltaHeight = Math.abs($(this.mapContainer).height() - this.mapMinimizedSize.height);
        var deltaWidth = Math.abs($(this.mapContainer).width() - this.mapMinimizedSize.width);
        var stepHeight = deltaHeight / steps * -1;
        var stepWidth = deltaWidth / steps * -1;

        $fx($(this.mediaContainer).get(0)).fxAdd({ type: "marginLeft", to: 330, step: stepWidth, delay: this.delay }).fxRun();
        $fx($(this.mapContainer).get(0)).fxAdd({ type: "height", to: this.mapMinimizedSize.height, step: stepHeight, delay: this.delay }).fxRun();
        $fx($(this.mapContainer).get(0)).fxAdd({ type: "width", to: this.mapMinimizedSize.width, step: stepWidth, delay: this.delay }).fxRun();

        /*
        setTimeout(function() {
        $('#comments').fadeIn(200);
        $('#titleBar').fadeIn(200);
        }, 500);
        */
    }
};