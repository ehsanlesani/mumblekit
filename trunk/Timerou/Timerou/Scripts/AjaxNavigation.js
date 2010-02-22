/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
function AjaxNavigation(defaultAction) {
    this.lastLocation = null;
    this.timer = null;
    this.locationsHistory = [];
    this.actions = {};
    this.action = null;
    this.parameters = {};
}

AjaxNavigation.LOCATION_CHANGED = "locationChanged";

AjaxNavigation.prototype = {
    start: function() {
        this.checkChanges();
    },

    goTo: function(url) {
        window.open(url, "_self");
    },

    checkChanges: function() {
        var self = this;
        if (this.lastLocation != window.location.href) {
            this.locationsHistory.push(this.lastLocation);
            this.lastLocation = window.location.href;
            this.process();
            $(this).trigger(AjaxNavigation.LOCATION_CHANGED);
        }
        this.timer = window.setTimeout(function() { self.checkChanges(); }, 250);
    },

    process: function() {
        this.action = null;
        this.parameters = {};

        //get current action and parameters
        if (this.lastLocation.indexOf("#") != -1) {
            var split1 = this.lastLocation.split("#");
            var split2 = split1[1].split("|");
            this.action = split2[0];
            for (var i = 1; i < split2.length; i++) {
                var keyValue = split2[i].split("=");
                this.parameters[keyValue[0]] = keyValue[1];
            }
        }

        if (this.action == null) {
            alert("action not setted");
            return;
        }

        if (Utils.isNullOrUndef(this.actions[this.action])) {
            alert("action " + this.action + " not found");
        }

        this.actions[this.action].execute(this.parameters);
    },

    addAction: function(name, action) {
        this.actions[name] = action;
    },

    clearActions: function() {
        this.actions = [];
    }
}