<%@ Page Title="Timerou: login page" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="LoginContent" ContentPlaceHolderID="BodyContent" runat="server">

    <script type="text/javascript" src="<%= UriHelper.Scripts %>Account.js"></script>

    <% Html.RenderPartial("~/Views/Controls/LoginControl.ascx"); %>

</asp:Content>
