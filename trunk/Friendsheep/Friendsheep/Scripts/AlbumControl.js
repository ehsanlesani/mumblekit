/// <reference path="jquery/jquery-1.3.2.js" />
/// <reference path="jquery/ajaxupload.js" />
/// <reference path="Utils.js" />
/// <reference path="Url.js" />
/// <reference path="jquery/ajaxupload.js" />

function PictureData() {
    this.description = "New picture";
    this.path = null;
    this.el = null;
    this.index = 0;
    this.currentAlbum = null;
}

function AlbumControl(container, userId) {   
    this.container = container;
    this.albums = [];
    this.userId = userId;
    this.currentIndex = 0;

    this.initialize();
}

AlbumControl.prototype = {

    initialize: function () {
        var self = this;

        //configure add album button
        $(this.container).find(".newAlbum").click(function () {
            self.createAlbum();
        });
        //configure album clicks
        $(this.container).find(".album").click(function () {
            var id = $(this).attr("albumId");
            self.selectAlbum(id);
        });

        //select the first album
        $(this.container).find(".album").eq(0).click();
    },

    load: function () { },

    createAlbum: function () {
        var self = this;

        self.container.find(".newAlbum")
            .html(CONFIRM + "?")
            .append($("<a/>")
                .attr("href", "javascript:;")
                .css("float", "right")
                .append($("<img/>")
                    .attr("src", Url.Images + "confirm.png")
                    .addClass("noborder")
                )
                .click(function () {
                    self.container.find(".newAlbum").html("Loading...")
                        .append($("<img/>")
                            .attr("src", Url.Images + "ajaxLoading.gif")
                            .addClass("noborder")
                            .css("float", "right")
                        );

                    $.post(Url.AccountCreateAlbum,
                        { userId: self.userId },
                        function (result) {
                            self.container.find(".newAlbum").html(NEW_ALBUM);

                            if (result.Error) {
                                alert(result.Message);
                            } else {
                                self.renderAlbum({ id: result.Id, title: result.Title });
                                self.selectAlbum(result.Id);
                            }
                        },
                        "json");
                    return false;
                })
            )
            .append($("<a/>")
                .attr("href", "javascript:;")
                .css("float", "right")
                .append($("<img/>")
                    .attr("src", Url.Images + "cancel.png")
                    .addClass("noborder")
                )
                .click(function () {
                    self.container.find(".newAlbum").html(NEW_ALBUM);
                    return false;
                })
            )
    },

    renderAlbum: function (album) {
        var self = this;
        $(this.container).find(".albumsList").append($("<a/>")
            .attr("href", "javascript:;")
            .addClass("album")
            .html(album.title)
            .attr("albumId", album.id)
            .click(function () {
                var id = $(this).attr("albumId");
                self.selectAlbum(id);
            })
        );
    },

    selectAlbum: function (albumId) {
        this.currentAlbum = albumId;
        $(this.container).find(".activeAlbum").removeClass("activeAlbum").addClass("album");
        $(this.container).find(".album[albumId=" + albumId + "]").removeClass("album").addClass("activeAlbum");

        $(this.container).find(".picturesList").empty();
        this.createAddPicture();
        this.loadPictures();
    },

    createAddPicture: function () {
        $pl = $(this.container).find(".pictureList");
        $(pl).append($("<a/>")
            .addClass("newPicture")
            .attr("href", "javascript:;")
            .append(
                $("<img />")
                    .attr("src", Url.Pictures + "addPicture.jpg")
                    .addClass("newPicture")
            )
        );

        new AjaxUpload($pl.find(".newPicture"), {
            action: Url.AccountAddPicture,
            data: {
                albumId: this.currentAlbum
            },
            onSubmit: function (file, ext) {
                //if (ext && new RegExp('^(' + allowed.join('|') + ')$').test(ext)){
                if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)) {
                    /* Setting data */
                    this.setData({
                        'key': 'This string will be send with the file'
                    });

                    $('#example2 .text').text('Uploading ' + file);
                } else {

                    // extension is not allowed
                    $('#example2 .text').text('Error: only images are allowed');
                    // cancel upload
                    return false;
                }

            },
            onComplete: function (file) {
                $('#example2 .text').text('Uploaded ' + file);
            }
        });

    },

    loadPictures: function () {
        if (this.currentAlbum == null) {
            return;
        }

        //set album as loading
        $(".album[albumId=" + this.currentAlbum + "]").append($("<img/>")
            .attr("src", Url.Images + "ajaxLoading.gif")
            .addClass("noborder")
            .css("float", "right")
            .attr("id", "albumLoading")
        );

        $.post(Url.AccountLoadPictures,
            { albumId: this.currentAlbum },
            function (result) {
                //remove loading from album tab
                $("#albumLoading").remove();
                if (result.Error) {
                    alert(result.Message);
                } else {
                    self.addAlbum({ id: result.Id, title: result.Title });
                    self.selectAlbum(result.Id);
                }
            }, "json");

    },

    renderPicture: function (picture) {

    },

    renderPictureEditor: function (pictureData) {

    }
};