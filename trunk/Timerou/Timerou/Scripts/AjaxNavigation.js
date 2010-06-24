/*
L'oggetto AjaxNavigation fornisce i metodi per associare ai cambiamenti dell'url sulla barra degli indirizzi delle azioni, in modo da attivare la history del browser
Un processo che viene eseguito ogni 250ms controlla se l'indirizzo è cambiato e fa un parse per instanziare l'azione richiesta.
Tutti gli oggetti Azione sono nella cartella Actions e sono degli oggetti che implementano il metodo execute() al quale vengono passati i parametri, 
sempre reperiti dalla barra degli indirizzi. 
ES: http://sitoweb/pagina_corrente#nome_azione|parametro1=valore|parametro2=valore
Per configurare l'azione si utilizza il metodo AjaxNavigation.addAction("nome_azione", instanzaAzione);

Per far eseguire il metodo execute() di instanzaAzione, basta impostare correttamente l'indirizzo corrente
es: location.href = #nome_azione|parametro1=valore|parametro2=valore.
Al metodo execute viene passato un oggetto cosi formato  
{
    parametro1: "valore",
    parametro2: "valore"
}

Questo metodo di navigazione è usato nella main page per mostrare il dettaglio di un media e per maximizzare la mappa
*/


/// <reference path="jquery/jquery-1.3.2-vsdoc.js" />
function AjaxNavigation(defaultAction) {
    this.lastLocation = null;
    this.timer = null;
    this.locationsHistory = [];
    this.actions = {};
    this.action = null;
    this.parameters = {};
}

AjaxNavigation.LOCATION_CHANGED = "locationChanged";

AjaxNavigation.prototype = {
    //avvia il processo che controlla cambiamenti sulla barra degli indirizzi
    start: function() {
        this.checkChanges();
    },
    
    //helper che apre l'url specificato nella finestra corrente
    goTo: function(url) {
        window.open(url, "_self");
    },

    //metodo del processo, viene autorichiamato e controlla cambiamenti nella barra indirizzi
    checkChanges: function() {
        var self = this;
        if (this.lastLocation != window.location.href) {
            this.locationsHistory.push(this.lastLocation);
            this.lastLocation = window.location.href;
            this.process();
            $(this).trigger(AjaxNavigation.LOCATION_CHANGED);
        }
        this.timer = window.setTimeout(function() { self.checkChanges(); }, 250);
    },

    //parserizza la stringa per controllare se ci sono azioni da eseguire
    process: function() {
        this.action = null;
        this.parameters = {};

        //get current action and parameters
        if (this.lastLocation.indexOf("#") != -1) {
            var split1 = this.lastLocation.split("#");
            var split2 = split1[1].split("|");
            this.action = split2[0];
            for (var i = 1; i < split2.length; i++) {
                var keyValue = split2[i].split("=");
                this.parameters[keyValue[0]] = keyValue[1];
            }
        }

        if (this.action == null) {
            //alert("action not setted");
            return;
        }

        if (Utils.isNullOrUndef(this.actions[this.action])) {
            alert("action " + this.action + " not found");
            return;
        }

        this.actions[this.action].execute(this.parameters);
    },

    //registra un azione
    addAction: function(name, action) {
        this.actions[name] = action;
    },
    
    //cancella tutte le azioni
    clearActions: function() {
        this.actions = [];
    }
};