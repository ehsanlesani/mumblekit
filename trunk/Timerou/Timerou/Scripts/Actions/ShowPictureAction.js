function ShowPictureAction(map) {
    if (Utils.isNullOrUndef(map)) {
        alert("ShowPictureAction require map");
    }
    this.map = map;
}
ShowPictureAction.prototype = {
    execute: function(params) {
        //alert(params.id);
    }
}
