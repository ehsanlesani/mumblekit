/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
function MapMediaTransition(mapContainer, mediaContainer) {
    this.mapMinimizedSize = { width: 150, height: 150 };
    this.mapMaximizedSize = { width: 960, height: 500 };
    
    this.mapContainer = mapContainer;
    this.mediaContainer = mediaContainer;
}

MapMediaTransition.prototype = {
    maximizeMap: function() {
        $(this.mapContainer).animate({ height: this.mapMaximizedSize.height, width: this.mapMaximizedSize.width }, 1000, "swing");
        $(this.mediaContainer).fadeOut(1000);
    },

    minimizeMap: function() {
        $(this.mapContainer).animate({ height: this.mapMinimizedSize.height, width: this.mapMinimizedSize.width }, 1000, "swing");
        $(this.mediaContainer).fadeIn(1000);
    }
};