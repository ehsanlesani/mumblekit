if (BASEURL == undefined) {
    alert("BASEURL not defined");
}

function Url() { };

Url.AccountRegister = BASEURL + "Account.aspx/Register/";
Url.AccountUpload = BASEURL + "Account.aspx/AddPicture/";
Url.AccountCulture = BASEURL + "Account.aspx/ChangeCulture/";
Url.AccountShare = BASEURL + "Account.aspx/Share/";

Url.CommentsCount = BASEURL + "Comments.aspx/Count/";
Url.CommentsLoad = BASEURL + "Comments.aspx/Load/";
Url.CommentsPost = BASEURL + "Comments.aspx/Post/";

Url.LoadOneMediaPerYear = BASEURL + "MediaLoader.aspx/LoadOneMediaPerYear/";
Url.LoadUserMedias = BASEURL + "Account.aspx/LoadUserMedias/";
Url.DeleteUserMedia = BASEURL + "Account.aspx/DeleteUserMedia";
Url.LoadMedias = BASEURL + "MediaLoader.aspx/LoadMedias/"
Url.LoadMedia = BASEURL + "MediaLoader.aspx/LoadMedia/"

Url.Location = BASEURL + "Location.aspx/";

Url.Pictures = BASEURL + "Pictures/";
Url.Images = BASEURL + "Content/Images/";

var BASEURL;  //for visualstudio intellisense