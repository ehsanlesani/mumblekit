<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<MailingList>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">Modifica contatto</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm()) {%>
    <div class="module">
        <h5>Modifica contatto</h5>
        <hr />
        <div class="module-section">
            <div class="w20 text-bold text-right"><label for="Name">Nome:</label></div>
            <div class="w50"><%= Html.TextBox("Name", Model.Name) %></div>
            <div class="w10"><%= Html.ValidationMessage("Name", "*") %></div>
        </div>
        <div class="module-section">
            <div class="w20 text-bold text-right"><label for="Surname">Cognome:</label></div>
            <div class="w50"><%= Html.TextBox("Surname", Model.Surname) %></div>
            <div class="w10"><%= Html.ValidationMessage("Surname", "*") %></div>
        </div>
        <div class="module-section">
            <div class="w20 text-bold text-right"><label for="Email">Email:</label></div>
            <div class="w50"><%= Html.TextBox("Email", Model.Email) %></div>
            <div class="w10"><%= Html.ValidationMessage("Email", "*") %></div>
        </div>
        <div class="module-section">
            <div class="w20 text-right"><label for="Phone">Telefono:</label></div>
            <div class="w50"><%= Html.TextBox("Phone", Model.Phone) %></div>
            <div class="w10"><%= Html.ValidationMessage("Phone", "*") %></div>
        </div>
        <hr />
        <div class="module-section">
            <div class="w70">
                <p class="text-left">
                    <img src="/Content/Images/Back.png" alt="Back" width="16" height="16" />
                    <%=Html.ActionLink("Torna alla lista dei prodotti", "Index") %>        
                </p>
            </div>
            <div class="w25 text-right">
                <input type="submit" value="Salva" class="text-big"/>
            </div>
        </div>
    </div>
    <% } %>
</asp:Content>


