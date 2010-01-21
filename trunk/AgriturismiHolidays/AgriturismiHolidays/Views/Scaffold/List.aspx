<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="Mumble.Web.StarterKit.Models.Scaffold.Mvc.ScaffoldViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	List
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% if(ViewData["Error"] != null) { %>
        <p class="error"><%= ViewData["Error"] %></p>
    <% } %>
    
    <% if(ViewData["Message"] != null) { %>
        <p class="message"><%= ViewData["Message"] %></p>
    <% } %>

    <% Scaffolder.List(ViewContext, EntityType); %>

</asp:Content>
