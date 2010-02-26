/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="libs/google.maps-v3-vsdoc.js" />
/// <reference path="Url.js" />

function ShareManager(lat, lng, zoom, year) {
    //initial values getted from main map
    this.lat = lat || 40.6686534; //initial lat
    this.lng = lng || 16.6060872; //initial lng
    this.zoom = zoom || 5; //initial zoom
    this.year = year || new Date().getFullYear(); //initial year
    this.marker = null;
    this.map = null;
    this.errorTimers = {};
    this.progressValue = 10; //progress bar variable for bar animation
    this.progressTimer = null;

    //check variables
    this.pictureUploaded = false;
    this.locationSelected = false;
}

ShareManager.prototype = {
    initialize: function() {
        var self = this;

        this.initializeSliders();
        this.initializeUpload();
        this.initializeMaps();
        this.initializeTextareas();

        //configure buttons
        $("#saveAndGoToUploadButton").click(function() { self.setInput("goToNewPicture", false); $("#pictureForm").submit(); });
        $("#saveAndGoToPictureButton").click(function() { self.setInput("goToNewPicture", true); $("#pictureForm").submit(); });

        $("#pictureForm").submit(function() {
            var allOk = true;

            if (!self.pictureUploaded) {
                allOk = false;
                self.showErrorBox("upload", SELECT_PICTURE);
            }

            if (!self.locationSelected) {
                allOk = false;
                self.showErrorBox("map", SELECT_LOCATION);
            }

            if ($("#pictureTitle").val().length == 0) {
                allOk = false;
                self.showErrorBox("info", CHECK_INFORMATIONS);
            }

            return allOk;
        });
    },

    initializeSliders: function() {
        var self = this;

        //check if editing picture and year already exists
        var loadedYear = self.getInput("year");
        if (loadedYear.length > 0) {
            self.year = parseInt(loadedYear);
        }

        $(".yearSlider").slider({
            min: 1839,
            max: new Date().getFullYear(),
            value: this.year,
            slide: function(event, ui) {
                self.year = ui.value;
                $("#yearLabel").html(self.year);
                self.setInput("year", self.year);
            }
        });

        $("#yearLabel").html(self.year);
        self.setInput("year", self.year);
    },

    initializeUpload: function() {
        var self = this;

        //if there is a picture id into hidden input, is sure that a image exists
        if (self.getInput("pictureId").length > 0) { self.pictureUploaded = true; }

        $("#uploadProgress").progressbar({ value: 10 });

        new AjaxUpload('uploadButton', {
            action: Url.AccountUpload,
            data: {
                guid: this.guid
            },
            autoSubmit: true,
            responseType: "json",
            onChange: function(file, extension) { },
            onSubmit: function(file, extension) {
                if (!(extension && /^(jpg|jpeg)$/.test(extension.toLowerCase()))) {
                    self.showErrorBox("upload", FORMAT_NOT_ALLOWED, 5000);
                    return false;
                }

                self.hideErrorBox("upload");

                $("#uploadStatus").show().html(UPLOADING + " " + file);
                $("#uploadProgress").show();

                //animate progress bar
                self.progressTimer = window.setInterval(function() {
                    self.progressValue += 10;
                    if (self.progressValue > 100) {
                        self.progressValue = 10;
                    }
                    $("#uploadProgress").progressbar("value", self.progressValue);
                }, 250);
            },
            onComplete: function(file, response) {
                //remove progressbar animation
                window.clearInterval(self.progressTimer);
                self.progressTimer = null;
                $("#uploadProgress").hide();

                if (response.error) {
                    self.showErrorBox("upload", response.message, 5000);
                } else {
                    self.pictureUploaded = true;
                    $("#uploadStatus").html(PICTURE_UPLOADED);
                    $("#uploadButton").find("img").attr("src", Url.Pictures + response.media.pictureData.avatarPath);

                    self.setInput("tempPictureId", response.media.id);
                }
            }
        });
    },

    initializeMaps: function() {
        var self = this;

        //initialize map
        self.map = new google.maps.Map(document.getElementById("map"), {
            center: new google.maps.LatLng(self.lat, self.lng),
            zoom: self.zoom,
            scrollwheel: true,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            mapTypeControl: false,
            scaleControl: false,
            navigationControl: true,
            disableDoubleClickZoom: true
        });

        google.maps.event.addListener(self.map, "click", function(e) {
            //get geolocation info of clicked point
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'latLng': e.latLng }, function(results, status) { self.geocodeResultHandler(results, status, e.latLng); });
        });

        //check if there is lat and lng loaded
        var loadedLat = self.getInput("lat");
        var loadedLng = self.getInput("lng");

        if (loadedLat.length > 0 && loadedLng.length > 0) {
            loadedLat = new Number(loadedLat);
            loadedLng = new Number(loadedLng);

            self.initializeMarker(new google.maps.LatLng(loadedLat, loadedLng));

            //set labels for user feedback
            $("#mapLocationLabel").html(self.getInput("address"));
            $("#mapLatLngLabel").html("Lat: " + loadedLat + ", Lng: " + loadedLng);

            self.locationSelected = true;
        }

        //initialize search location
        //set default action if ENTER is pressed
        $("#mapSearchKeyword").keypress(function(e) {
            if (e.which == 13) {
                $("#mapSearchButton").click();
            }
        });

        $("#mapSearchButton").click(function() {
            //get geocode position
            var keyword = $("#mapSearchKeyword").val();
            if (keyword.length == 0) {
                $("#mapSearchKeyword").focus();
            }

            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ address: keyword }, function(results, status) { self.geocodeResultHandler(results, status); });
        });
    },

    geocodeResultHandler: function(results, status, markerLatLng, previousLatLng) {
        var self = this;
        if (status == google.maps.GeocoderStatus.OK) {
            Utils.trace(results);

            //hide error box if visible
            self.hideErrorBox("map");
            var bestResult = results[0];

            //if marker latlng is null or undefined the handler is called by keyword search result, otherwise by map mouse click
            if (Utils.isNullOrUndef(markerLatLng)) {
                markerLatLng = bestResult.geometry.location;
            }

            //create marker object if not already created
            if (self.marker == null) {
                self.initializeMarker(markerLatLng);
            }

            //move map and marker to correct position
            self.marker.setPosition(markerLatLng);
            self.map.panTo(markerLatLng);

            //set labels for user feedback
            $("#mapLocationLabel").html(bestResult.formatted_address);
            $("#mapLatLngLabel").html("Lat: " + markerLatLng.lat() + ", Lng: " + markerLatLng.lng());

            //set inputs values using best result (usually the first)
            var country = self.findCountryFromResult(bestResult);
            var region = self.findRegionFromResult(bestResult);
            var province = self.findProvinceFromResult(bestResult);
            var postalCode = self.findPostalCodeFromResult(bestResult);
            var city = self.findCityFromResult(bestResult);
            var address = self.findAddressFromResult(bestResult);

            self.setInput("country", country != null ? country.longName : "");
            self.setInput("countryCode", country != null ? country.shortName : "");
            self.setInput("region", region != null ? region.shortName : "");
            self.setInput("postalCode", postalCode != null ? postalCode.shortName : "");
            self.setInput("city", city != null ? city.shortName : "");
            self.setInput("province", province != null ? province.shortName : "");
            self.setInput("address", address != null ? address.longName : bestResult.formatted_address);
            self.setInput("lat", markerLatLng.lat());
            self.setInput("lng", markerLatLng.lng());

            //set title with formatted_address
            $("#pictureTitle").val(bestResult.formatted_address);

            self.locationSelected = true;

        } else {
            //show error box
            self.showErrorBox("map", LOCATION_UNAVAILABLE, 5000);

            //if previus marker position is specified (usually from d&d), last position is restored
            if (!Utils.isNullOrUndef(previousLatLng)) {
                if (self.marker != null) {
                    self.marker.setPosition(previousLatLng);
                }
            }

            Utils.trace("Geocoder failed due to: " + status);
        }
    },

    initializeMarker: function(markerLatLng) {
        var self = this;

        self.marker = new google.maps.Marker({
            position: markerLatLng,
            map: self.map,
            draggable: true
        });

        //drag&drop needs to store initial position to restore back position in case of geocode error
        var markerStartPosition = null;
        //initialize marker drag&drop
        google.maps.event.addListener(self.marker, "dragstart", function(e) {
            markerStartPosition = self.marker.getPosition();
        });

        google.maps.event.addListener(self.marker, "dragend", function(e) {
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'latLng': e.latLng }, function(results, status) { self.geocodeResultHandler(results, status, e.latLng, markerStartPosition); });
        });
    },

    findCountryFromResult: function(result) {
        return this.findFromResult(result, "country");
    },

    findRegionFromResult: function(result) {
        return this.findFromResult(result, "administrative_area_level_1");
    },

    findProvinceFromResult: function(result) {
        return this.findFromResult(result, "administrative_area_level_2");
    },

    findPostalCodeFromResult: function(result) {
        return this.findFromResult(result, "postal_code");
    },

    findCityFromResult: function(result) {
        return this.findFromResult(result, "locality");
    },

    findAddressFromResult: function(result) {
        var route = this.findFromResult(result, "route");
    },

    findFromResult: function(result, key) {
        var value = null;

        $(result.address_components).each(function(i, address) {
            if ($.inArray(key, address.types) != -1) {
                value = { longName: address.long_name, shortName: address.short_name };
                return;
            }
        });

        return value;
    },

    initializeTextareas: function() {
        var self = this;

        $("#pictureTitle").change(function() {
            if ($("#pictureTitle").val().length > 0) {
                self.hideErrorBox("info");
            } else {
                self.showErrorBox("info", CHECK_INFORMATIONS);
            }
        });

        tinyMCE.init({
            mode: "textareas",
            theme: "simple",
            editor_selector: "bodyEditor",
            editor_deselector: "mceNoEditor"
        });
    },

    setInput: function(inputName, value) {
        $('input[type="hidden"][name="' + inputName + '"]').val(value);
    },

    getInput: function(inputName) {
        return $('input[type="hidden"][name="' + inputName + '"]').val();
    },

    showErrorBox: function(area, message, closeDelay) {
        if (!Utils.isNullOrUndef(this.errorTimers[area])) {
            window.clearTimeout(this.errorTimers[area]);
        }

        $("#" + area + "ErrorBox").html(message)
        $("#" + area + "ErrorBox:hidden").show("blind", 250);
        if (!Utils.isNullOrUndef(closeDelay)) {
            this.errorTimers[area] = window.setInterval(function() { $("#" + area + "ErrorBox:visible").hide("blind", 250) }, closeDelay);
        }
    },

    hideErrorBox: function(area, message, closeDelay) {
        if (!Utils.isNullOrUndef(this.errorTimers[area])) {
            window.clearTimeout(this.errorTimers[area]);
        }

        $("#" + area + "ErrorBox:visible").hide("blind", 250)
    }
};
