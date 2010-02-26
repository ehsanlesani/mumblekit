if (BASEURL == undefined) {
    alert("BASEURL not defined");
}

function Url() { };

Url.AccountRegister = BASEURL + "Account.aspx/Register/";
Url.AccountUpload = BASEURL + "Account.aspx/AddPicture/";
Url.AccountCulture = BASEURL + "Account.aspx/ChangeCulture/";
Url.AccountShare = BASEURL + "Account.aspx/Share/";

Url.LoadOneMediaPerYear = BASEURL + "MediaLoader.aspx/LoadOneMediaPerYear/";
Url.LoadUserMedias = BASEURL + "Account.aspx/LoadUserMedias/"
Url.LoadMedias = BASEURL + "MediaLoader.aspx/LoadMedias/"
Url.LoadMedia = BASEURL + "MediaLoader.aspx/LoadMedia/"

Url.Location = BASEURL + "Location.aspx/"

Url.Pictures = BASEURL + "Pictures/";
Url.Images = BASEURL + "Content/Images/";

var BASEURL;