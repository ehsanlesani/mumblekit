/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
/// <reference path="Url.js" />
/// <reference path="Utils.js" />

function MyMemoriesManager() {
    this.page = 1;
    this.pageSize = 20;
}

MyMemoriesManager.prototype = {
    initialize: function() {
        var self = this;
        $("#searchForm").submit(function() { self.loadMedias(); return false; });

        this.loadMedias();
    },

    loadMedias: function() {
        var self = this;
        $("#loading").fadeIn(250);

        $.post(Url.LoadUserMedias, {
            keyword: $("#keyword").val(),
            year: $("#year").val(),
            page: this.page,
            pageSize: this.pageSize
        }, function(response) {
            $("#loading").fadeOut(250);

            if (response.error) {
                Utils.showSiteError(response.message);
                return;
            }

            $("#userMediasContainer").empty();
            var size = response.medias.length;
            for (var i = 0; i < size; i++) {
                var media = response.medias[i];
                if (media.type == "Picture") {
                    //load template
                    var pictureRender = self._renderPicture(media);
                    $("#userMediasContainer").append(pictureRender);
                } else if (media.type == "Video") {
                    alert("Video renderer not implemented");
                }
            }

        }, "json");
    },

    _renderPicture: function(media) {
        var picture = $("#mediaRowTemplate")
            .clone()
            .attr("id", "media_" + media.id)
            .find("#avatarImage")
                .removeAttr("id")
                .attr("src", Url.Pictures + media.pictureData.avatarPath)
                .end()
            .find("#title")
                .removeAttr("id")
                .html(media.title)
                .end()
            .find("#address")
                .removeAttr("id")
                .html(media.address)
                .end()
            .find("#mediaYear")
                .removeAttr("id")
                .html(media.year)
                .end()
            .find("#editButton")
                .removeAttr("id")
                .click(function() {
                    window.open(Url.AccountShare + media.id);
                })
                .end()
            .find("#deleteButton")
                .attr("id", "deleteButton" + media.id)
                .click(function() {
                    if (Utils.isNullOrEmpty($("#deleteButton" + media.id).data("waitForConfirm"))) {
                        var oldText = $("#deleteButton" + media.id).html();
                        $("#deleteButton" + media.id)
                            .data("waitForConfirm", true)
                            .html(ONE_MORE_TIME);

                        window.setTimeout(function() { $("#deleteButton" + media.id).data("waitForConfirm", null).html(oldText); }, 2000)
                    } else {
                        alert("delete");
                    }


                })
                .end();

        return picture;
    }
};