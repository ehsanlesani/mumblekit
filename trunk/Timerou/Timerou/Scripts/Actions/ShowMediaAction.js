function ShowMediaAction(detailsManager) {
    if (Utils.isNullOrUndef(detailsManager)) {
        alert("ShowPictureAction require detailsManager");
    }
    this.detailsManager = detailsManager;
}
ShowMediaAction.prototype = {
    execute: function(params) {
        this.detailsManager.displayMedia(params.id);
    }
}
