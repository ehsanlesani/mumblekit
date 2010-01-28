/// <reference path="Url.js" />
var __progressValue = 10;
var __timer = null;

function Uploader(lat, lng, zoom) {
    this.year = new Date().getFullYear();
    this.lat = lat;
    this.lng = lng;
    this.zoom = zoom;
    this.pictureUploaded = false;
    this.pictureId = null;
    
    this.initialize();
}

Uploader.prototype = {
    initialize: function() {
        this.initializeSliders();
        this.initializeUpload();
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

    initializeUpload: function() {
        var self = this;

        $(".uploadProgress").progressbar({ value: 10 });

        new AjaxUpload('uploadButton', {
            action: Url.AccountUpload,
            data: {
                guid: this.guid
            },
            autoSubmit: true,
            responseType: "json",
            onChange: function(file, extension) { },
            onSubmit: function(file, extension) {
                $(".uploadStatus").html("Uploading " + file + "." + extension);

                $(".uploadStatus").show();
                $(".uploadProgress").show();

                //animate progress bar
                __timer = window.setInterval(function() {
                    __progressValue += 10;
                    if (__progressValue > 100) {
                        __progressValue = 10;
                    }
                    $(".uploadProgress").progressbar("value", __progressValue);
                }, 250);
            },
            onComplete: function(file, response) {
                self.pictureUploaded = true;
                self.pictureId = response.id;
                $(".uploadStatus").html("Picture uploaded");
                
                //remove progressbar animation
                window.clearInterval(__timer);
                __timer = null;
                $(".uploadProgress").hide();

                $("#uploadButton").find("img").attr("src", Url.Pictures + response.picture.avatarPath);
            }
        });


    },

    initializeMaps: function() {
        var map = new google.maps.Map2(document.getElementById("map"));
        map.setCenter(new google.maps.LatLng(40.0, 40.0), 10);
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