<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<MailingListGroup>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">Modifica gruppo</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm()) {%>
    <div class="module">
        <h5>Modifica gruppo</h5>
        <hr />
        <div class="module-section">
            <div class="w20 text-bold text-right"><label for="Email">Name:</label></div>
            <%= Html.Hidden("GroupId", Model.GroupID) %>
            <div class="w50"><%= Html.TextBox("Name", Model.Name) %></div>
            <div class="w10"><%= Html.ValidationMessage("Name", "*") %></div>
        </div>
        <hr />
        <div class="module-section">
            <div class="w70">
                <p class="text-left">
                    <img src="/Content/Images/Back.png" alt="Back" width="16" height="16" />
                    <%=Html.ActionLink("Torna alla lista dei contatti", "Index") %>        
                </p>
            </div>
            <div class="w25 text-right">
                <input type="submit" value="Salva" class="text-big"/>
            </div>
        </div>
    </div>
    <% } %>
</asp:Content>


