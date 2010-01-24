/// <reference path="jquery/jquery-1.3.2.js" />
/// <reference path="jquery/ajaxupload.js" />
/// <reference path="Utils.js" />
/// <reference path="Url.js" />
/// <reference path="jquery/ajaxupload.js" />

function PictureData(data) {
    this.description = "New picture";
    this.path = null;
    this.el = null;
    this.index = 0;
    this.currentAlbum = null;

    $.extend(this, data);
}

function AlbumControl(container, userId) {   
    this.container = container;
    this.userId = userId;
    this.currentIndex = 0;
    this.pictures = [];

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
        $(this.container).find(".album").each(function (i, albumUi) { self.configureAlbumEvents(albumUi); });

        //select the first album
        $(this.container).find(".album").eq(0).click();
    },

    configureAlbumEvents: function (albumUi) {
        var self = this;

        $(albumUi).click(function () {
            var id = $(this).attr("albumId");
            self.selectAlbum(id);
        }).hover(function () {
            var id = $(this).attr("albumId");
            self.showAlbumActions(id);
        }, function () {
            var id = $(this).attr("albumId");
            self.hideAlbumActions(id);
        });
    },

    showConfirm: function (selector, confirmFn, cancelFn) {
        var previousHtml = selector.html();

        selector
            .html(CONFIRM + "?")
            .append($("<a/>")
                .attr("href", "javascript:;")
                .css("float", "right")
                .append($("<img/>")
                    .attr("src", Url.Images + "confirm.png")
                    .addClass("noborder")
                )
                .click(function () {
                    //restore previous html
                    selector.html(previousHtml);
                    if (confirmFn) { confirmFn(); }
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
                    //restore previous html
                    selector.html(previousHtml);
                    if (cancelFn) { cancelFn(); }
                    return false;
                })
            );
    },

    showLoading: function (selector) {
        selector.html("Loading...")
            .append($("<img/>")
                .attr("src", Url.Images + "ajaxLoading.gif")
                .addClass("noborder")
                .css("float", "right")
            );
    },

    createAlbum: function () {
        var self = this;

        this.showConfirm(this.container.find(".newAlbum"), function () {
            self.showLoading(self.container.find(".newAlbum"));

            $.post(Url.AccountCreateAlbum,
                    { userId: self.userId },
                    function (result) {
                        self.container.find(".newAlbum").html(NEW_ALBUM);

                        if (result.error) {
                            alert(result.message);
                        } else {
                            self.renderAlbum(result);
                            self.selectAlbum(result.id);
                        }
                    },
                    "json");
        });
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

        this.configureAlbumEvents(album.id);
    },

    selectAlbum: function (albumId) {
        //if current album is selected no selection is needed
        if (this.currentAlbum == albumId) { return; }
        this.currentAlbum = albumId;

        //mouse is over and actions are showing. this is needed to remove actions while loading
        this.hideAlbumActions(albumId);

        $(this.container).find(".activeAlbum").removeClass("activeAlbum").addClass("album");
        $(this.container).find(".album[albumId=" + albumId + "]").removeClass("album").addClass("activeAlbum");

        $(this.container).find(".picturesList").empty();

        this.createAddPicture();
        //add clear div because pictures are float:left;
        $(this.container).find(".picturesList").append($("<div class='clear' />"));
        this.loadPictures();
    },

    showAlbumActions: function (albumId) {
        $(this.container).find(".album[albumId=" + albumId + "]").append($("<a/>")
                .attr("href", "javascript:;")
                .addClass("albumAction")
                .css("float", "right")
                .css("opacity", 0.5)
                .hover(function () { $(this).css("opacity", 1); }, function () { $(this).css("opacity", 0.5); })
                .append($("<img/>")
                    .attr("src", Url.Images + "delete.png")
                    .addClass("noborder")
                )
                .click(function () {
                    //restore previous html
                    
                    return false;
                })
            )
            .append($("<a/>")
                .attr("href", "javascript:;")
                .addClass("albumAction")
                .css("float", "right")
                .css("opacity", 0.5)
                .hover(function () { $(this).css("opacity", 1); }, function () { $(this).css("opacity", 0.5); })
                .append($("<img/>")
                    .attr("src", Url.Images + "edit.png")
                    .addClass("noborder")
                )
                .click(function (e) {
                    var box = new ActionBox($("<input type='text' />"));
                    box.show({
                        x: e.pageX,
                        y: e.pageY
                    });
                    return false;
                })
            );
    },

    hideAlbumActions: function (albumId) {
        $(this.container).find(".album[albumId=" + albumId + "]").find(".albumAction").remove();
    },

    createAddPicture: function () {
        var self = this;

        var $pl = $(this.container).find(".picturesList");
        var $addPicture = $("<div/>")
            .addClass("newPicture")
            .append(
                $("<img />")
                    .attr("src", Url.Pictures + "addPicture.jpg")
            );

        $pl.append($addPicture);

        new AjaxUpload($addPicture, {
            action: Url.AccountAddPicture,
            data: {
                albumId: this.currentAlbum
            },
            onSubmit: function (file, ext) {
                if (ext && /^(jpg|png|jpeg|gif)$/.test(ext.toLowerCase())) {
                    $pl.find(".newPicture").find("img").attr("src", Url.Pictures + "pictureAdding.gif");
                } else {
                    return false;
                }
            },
            onComplete: function (file, result) {
                $pl.find(".newPicture").find("img").attr("src", Url.Pictures + "addPicture.jpg");

                var data = window["eval"]("(" + result + ")");
                if (data.error) {
                    alert(data.message);
                } else {
                    var picture = new PictureData(data.picture);
                    self.pictures.push(picture);
                    self.renderPicture(picture);
                }
            }
        });

    },

    loadPictures: function () {
        if (this.currentAlbum == null) {
            return;
        }

        var self = this;
        this.pictures = [];

        //set album as loading
        $("a[albumId=" + this.currentAlbum + "]").append($("<img/>")
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
                if (result.error) {
                    alert(result.message);
                } else {
                    $(result.pictures).each(function (i, data) {
                        var picture = new PictureData(data);
                        self.pictures.push(picture);
                        self.renderPicture(picture);
                    });
                }
            }, "json");

    },

    renderPicture: function (picture) {
        picture.el = $("<a href='javascript:;' />")
            .addClass("picture")
            .append($("<img />")
                .attr("src", Url.Pictures + picture.avatarPath)
            )
            .insertBefore($(this.container).find(".picturesList").find(".clear"));
    },

    renderPictureEditor: function (pictureData) {

    }
};