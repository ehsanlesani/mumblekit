<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LoginModel>" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>

<div id="header_logon">    
    <% Html.RenderPartial("~/Views/Controls/LoginControl.ascx"); %>      
</div>
