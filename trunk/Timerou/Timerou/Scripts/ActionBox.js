/// <reference path="jquery/jquery-1.3.2.js" />
function ActionBox(content) {
    this.content = content;
    this.el = null;
}

ActionBox.prototype = {
    show: function (opt) {
        var self = this;

        //initialize options
        var options = $.extend({
            x: 0,
            y: 0,
            height: null,
            width: null,
            buttons: {
                Close: function () { self.hide(); }
            }
        }, opt);

        //create box
        var box = $("<div />")
            .addClass("actionbox")
            .css("position", "absolute")
            .css("left", options.x + "px")
            .css("top", options.y + "px")
            .css("z-index", 1000)
            .append(this.content);

        if (options.height != null) {
            box.css("height", options.height + "px")
        }

        if (options.width != null) {
            box.css("width", options.width + "px")

            $.each(options.buttons, function (name, fn) {
                box.find(".buttonsBar").append($("<a href='javascript:;' />"))
                .addClass("button")
                .html(name)
                .click(function () { if (fn) { fn(); } });
            });
        }

        if ($(options.buttons).size() > 0) {
            var buttonsBar = box.append($("<div />")
                .addClass("buttonsbar")
            );

            $.each(options.buttons, function (name, fn) {
                box.find(".buttonsbar").append($("<a href='javascript:;' />")
                    .addClass("button")
                    .html(name)
                    .click(function () { if (fn) { fn(); } })
                );
            });
        }

        this.el = box;

        $("body").append(box);
    },

    hide: function () {
        this.el.remove();
    }
};