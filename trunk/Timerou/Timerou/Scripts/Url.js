if (BASEURL == undefined) {
    alert("BASEURL not defined");
}

function Url() { };

Url.AccountRegister = BASEURL + "Account.aspx/Register/";
Url.AccountUpload = BASEURL + "Account.aspx/AddPicture";
Url.AccountCulture = BASEURL + "Account.aspx/ChangeCulture";

Url.LoadOnePicturePerYear = BASEURL + "Map.aspx/LoadOnePicturePerYear";

Url.Location = "Location.aspx/"

Url.Pictures = BASEURL + "Pictures/";
Url.Images = BASEURL + "Content/Images/";

var BASEURL;