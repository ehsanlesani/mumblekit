/// <reference path="jquery/jquery-1.3.2.js" />
function ActionBox(content) { 
    this.content = content;
}

ActionBox.prototype = {
    show: function (opt) {
        var self = this;

        //initialize options
        var options = $.extend({
            x: 0,
            y: 0,
            height: 250,
            width: 400,
            buttons: {
                OK: function () { self.close(); }
            }
        }, opt);

        //create box
        var box = $("<div />")
            .addClass("actionbox")
            .css("position", "absolute")
            .css("left", options.x + "px")
            .css("top", options.y + "px")
            .css("height", options.height + "px")
            .css("width", options.width + "px")
            .css("z-index", 1000)
            .append(this.content)
            .append($("<div />")
                .addClass(".buttonsBar")
            );

        $.each(options.buttons, function (name, fn) {
            box.find(".buttonsBar").append($("<a href='javascript:;' />"))
                .addClass("button")
                .html(name)
                .click(function () { if (fn) { fn(); } });
        });

        $("body").append(box);
    }
};