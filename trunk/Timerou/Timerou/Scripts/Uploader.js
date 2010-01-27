var __progressValue = 10;

function Uploader(container) {
    this.container = container;
    this.year = new Date().getFullYear();
    
    this.initialize();
}

Uploader.prototype = {
    initialize: function() {
        this.initializeSliders();
        this.initializeProgress();
        this.initializeMaps();
        this.initializeTextareas();
    },

    initializeSliders: function() {
        var self = this;

        $(".yearSlider").slider({
            min: 1839,
            max: 2010,
            value: this.year,
            slide: function(event, ui) {
                self.year = ui.value;
                $(".year").html(self.year);
            }
        });

        $(".year").html(self.year);
    },

    initializeProgress: function() {
        $(".uploadProgress").progressbar({ value: 10 });
        window.setInterval(function() {
            __progressValue += 10;
            if (__progressValue > 100) {
                __progressValue = 10;
            }
            $(".uploadProgress").progressbar("value", __progressValue);
        }, 500);
    },


    initializeMaps: function() {
        var map = new google.maps.Map2(document.getElementById("map"));
        map.setCenter(new google.maps.LatLng(37.4419, -122.1419), 5);
    },

    initializeTextareas: function() {
        tinyMCE.init({
            mode: "textareas",
            theme: "simple",
            editor_selector: "bodyEditor",
            editor_deselector: "mceNoEditor"
        });
    }
};