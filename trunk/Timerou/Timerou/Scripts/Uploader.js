/// <reference path="libs/google.maps-v3-vsdoc.js" />
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
    this.marker = null;
    
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
                $(".uploadStatus").show();
                if (!extension || !/^(jpg|jpeg)$/.test(extension.toLowerCase())) {
                    $(".uploadStatus").html(FORMAT_NOT_ALLOWED);
                    return false;
                }

                $(".uploadStatus").html(UPLOADING + " " + file);
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
                //remove progressbar animation
                window.clearInterval(__timer);
                __timer = null;
                $(".uploadProgress").hide();

                if (response.error) {
                    $(".uploadStatus").html(response.message);
                } else {
                    self.pictureUploaded = true;
                    self.pictureId = response.id;
                    $(".uploadStatus").html(PICTURE_UPLOADED);
                    $("#uploadButton").find("img").attr("src", Url.Pictures + response.picture.avatarPath);
                }
            }
        });
    },

    initializeMaps: function() {
        var self = this;

        var map = new google.maps.Map(document.getElementById("map"), {
            center: new google.maps.LatLng(50, 50),
            zoom: 5,
            scrollwheel: true,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            mapTypeControl: false,
            scaleControl: false
        });

        google.maps.event.addListener(map, "click", function(e) {
            if (self.marker == null) {
                self.marker = new google.maps.Marker({
                    position: e.latLng,
                    map: map
                });
            }

            //get geolocation info of clicked point
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'latLng': e.latLng }, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    self.marker.setPosition(e.latLng);
                    map.panTo(e.latLng);
                    $(".address").html(results[0].formatted_address);
                } else {
                    alert("Geocoder failed due to: " + status);
                }
            });
        });
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