/// <reference path="jquery/jquery-1.3.2.js" />
/// <reference path="jquery/ajaxupload.js" />
/// <reference path="Utils.js" />

function PictureData() {
    this.description = "New picture";
    this.path = null;
    this.action = "add";
    this.el = null;
    this.index = 0;
}

function PictureManager(container, userId) {
    this.container = container;
    this.pictures = [];
    this.userId = userId;
    this.currentIndex = 0;
}

PictureManager.prototype = {
    load: function () { },

    add: function () {
        var pictureData = new PictureData();
        this.currentIndex++;
        pictureData.index = this.currentIndex;
        this.pictures.push(pictureData);
        this.renderPictureEditor(pictureData);
    },

    renderPictureEditor: function (pictureData) {
        var pictureUrl = Url.Pictures + "default_avatar.png";
        if (pictureData.path != null) {
            pictureUrl = Url.Pictures + pictureData.path;
        }

        var pictureEditor = $("#pictureEditorTemplate").clone();
        pictureEditor.attr("id", "pictureEditor" + pictureData.index);
        pictureEditor.find(".picture")
            .attr("src", pictureUrl)
            .click(function () { alert("ciao"); });
        pictureEditor.find(".description")
            .val(pictureData.description)
            .change(function () { alert("change"); });
        pictureEditor.find(".profilePictureButton")
            .click(function () { alert("profile"); });
        pictureEditor.find(".deleteButton")
            .click(function () { alert("delete"); });

        pictureData.el = pictureEditor;
        $(this.container).append(pictureData.el);

        this.checkDone(pictureData);
    },

    checkDone: function (pictureData) {
        if (pictureData.path == null || Utils.isNullOrEmpty(pictureData.description)) {
            if (!$(pictureData.el).hasClass("undone")) {
                $(pictureData.el).addClass("undone", 1000);
            }
        } else {
            if ($(pictureData.el).hasClass("undone")) {
                $(pictureData.el).removeClass("undone", 1000);
            }
        }
    }
};