<%@ Page Title="Friendsheep: login page" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="LoginContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" src="<%= UriHelper.Scripts %>Account.js"></script>

    <% Html.RenderPartial("~/Views/Controls/LoginControl.ascx"); %>

</asp:Content>
