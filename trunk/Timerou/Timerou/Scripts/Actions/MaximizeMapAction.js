function MaximizeMapAction(transition) {
    if (Utils.isNullOrUndef(transition)) {
        alert("MaximizeMapAction require transition");
    }
    this.transition = transition;
}
MaximizeMapAction.prototype = {
    execute: function(params) {
        this.transition.maximizeMap();
    }
}