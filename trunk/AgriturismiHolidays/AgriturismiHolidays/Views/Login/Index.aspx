<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AdminHome
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% if(ViewData["User"] != null) { %>
        Benvenuto <%= ViewData["User"] %>
    <% } else { %>
        <% Html.RenderPartial("LoginControl"); %>
    <% } %>    

</asp:Content>
