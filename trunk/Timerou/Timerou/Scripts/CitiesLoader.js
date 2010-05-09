// :) ciao, sono citiesloader :D
// ...tu mi hai offeso caro bruno di merda :\
// cambi continuamente modo di scrivere il codice :°°°°°(

function CitiesLoader(swlat, swlng, nelat, nelng, year) {
    this._swlat = swlat;
    this._swlng = swlng;
    this._nelat = nelat;
    this._nelng = nelng;
    this._year = year;
};

CitiesLoader.prototype = {

    // bounds and year?!
    load: function() {
        $.post(Url.LoadCities, {
            swlat: this._swlat,
            swlng: this._swlng,
            nelat: this._nelat,
            nelng: this._nelng,
            year: this._year
        }, function(response) {
            $('#navContent').empty();

            $.each(response.info, function(index, location) {
                if (location.city != undefined && 
                        location.city != "")             
                    $('#navContent').append(location.city + '<br />');
            });
        }, "json");
    }
};