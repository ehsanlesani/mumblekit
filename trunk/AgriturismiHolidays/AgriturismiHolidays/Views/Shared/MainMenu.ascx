<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.Common" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Views.Utilities.Helpers" %>

<ul id="menu-list">
    <li class="first"><a href="http://<%=Request.ServerVariables["HTTP_HOST"]%>"><img src="../../Content/Images/homeicon.png" alt="home" id="homeicon" />Home</a></li>
    <%=Html.TabbedMenu(ViewData["MenuTabs"] as IEnumerable<MenuTab>)%>
</ul>