// :) ciao, sono citiesloader :D
// ...tu mi hai offeso caro bruno di merda :\
// cambi continuamente modo di scrivere il codice :°°°°°(

function CitiesLoader() { };

CitiesLoader.prototype = {

    // bounds and year?!
    load: function() {
        $.post(Url.LoadCities, {
            swlat: bounds.swlat,
            swlng: bounds.swlng,
            nelat: bounds.nelat,
            nelng: bounds.nelng,
            year: this.year
        }, function(response) {
            response.Info.each( function(index, value) {
                $('navContent').append('citta:'+ value.City);
            });            
        }, "json");
    }
};