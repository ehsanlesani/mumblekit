<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="Mumble.Timerou.Models.Auth.AuthPage" %>

<asp:Content ID="ControlPanelContent" ContentPlaceHolderID="MainContent" runat="server">

    <% Html.RenderPartial("~/Views/Account/Controls/AlbumControl.ascx", new AlbumModel(AccountManager.LoggedUser)); %>
    
</asp:Content>
