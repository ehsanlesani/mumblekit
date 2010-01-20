function Events() { };
Events.NEW_FARM_STATUSES = "NEW_FARM_STATUSES";

var EventHandler = function(event, handler) {
    this.event = event;
    this.handler = handler;
};

var EventPool = function () {
    this.handlers = [];
};

EventPool.prototype = {
    //Register a js handler for a server event
    addHandler: function (event, handler) {
        this.handlers.push(new EventHandler(event, handler));
    },

    //Remove a js handler for a server event. Handler is not mandatory
    removeHandler: function (event, handler) {
        var newHandlers = [];
        for (var i = 0; i < this.handlers.length; i++) {
            var eh = this.handlers[i];
            if (eh.event != event) {
                if (handler == undefined || eh.handler == handler) {
                    newHandlers.push(eh);
                }
            }
        }
        this.handlers = newHandlers;
    },

    //start listening event from server
    _begin: function () {
        
    }
};

//singleton
EventPool.instance = new EventPool();