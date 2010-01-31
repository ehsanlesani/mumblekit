function ActionBox(content) {
    this.content = content;
    this.el = null;
    this.options = {};
}

ActionBox.prototype = {
    show: function(opt) {
        var self = this;

        //initialize options
        this.options = $.extend({
            x: 0,
            y: 0,
            height: null,
            width: null,
            buttons: {
                Close: function() { self.hide(); }
            }
        }, opt);

        //create box
        var box = $("<div />")
            .addClass("actionbox")
            .css("position", "absolute")
            .css("left", this.options.x + "px")
            .css("top", this.options.y + "px")
            .css("z-index", 1000)
            .append(this.content);

        if (this.options.height != null) {
            box.css("height", this.options.height + "px")
        }

        if (this.options.width != null) {
            box.css("width", this.options.width + "px")
        }

        if ($(this.options.buttons).size() > 0) {
            var buttonsBar = box.append($("<div />")
                .addClass("buttonsbar")
            );

            $.each(this.options.buttons, function(name, fn) {
                box.find(".buttonsbar").append($("<a href='javascript:;' />")
                    .addClass("button")
                    .html(name)
                    .click(function() { if (fn) { fn(); } })
                );
            });
        }

        this.el = box;

        $("body").append(box);

        this.options.height = this.el.height();
        this.options.width = this.el.width();
    },

    hide: function() {
        this.el.remove();
    },

    center: function() {
        this.options.x = ($(window).height() / 2) - (this.options.height / 2);
        this.options.y = ($(window).width() / 2) - (this.options.width / 2);

        this.el.css("top", this.options.x + "px");
        this.el.css("left", this.options.y + "px");
    }
};