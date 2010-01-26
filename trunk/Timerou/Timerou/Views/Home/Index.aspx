<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="Mumble.Timerou.Models.Auth.AuthPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="<%= UriHelper.Scripts %>Home.js" type="text/javascript"></script>
    
    Welcome <%= AccountManager.LoggedUser.FirstName %>

</asp:Content>
