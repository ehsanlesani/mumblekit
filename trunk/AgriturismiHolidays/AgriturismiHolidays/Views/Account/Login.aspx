<%@ Page Title="Timerou: login page" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="LoginContent" ContentPlaceHolderID="MainContent" runat="server">

    <% Html.RenderPartial("~/Views/Controls/LoginControl.ascx"); %>

</asp:Content>
