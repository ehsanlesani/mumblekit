<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<MailingList>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">Crea un nuovo contatto</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm()) {%>
    <div class="module">
        <center><h3>Creazione di un nuovo contatto</h3></center>
        <br /><br />
        <center>
        <div class="module-section">
            <div class="w20 text-bold text-right"><label for="Email">Email:</label></div>
            <div class="w50"><%= Html.TextBox("Email") %></div>
            <div class="w10"><%= Html.ValidationMessage("Email", "*") %></div>
        </div>
        <div class="module-section">
            <div class="w70">
                <p class="text-left">
                    <img src="/Content/Images/Back.png" alt="Back" width="16" height="16" />
                    <%=Html.ActionLink("Torna alla lista contatti", "Index") %>        
                </p>
            </div>
            <div class="w25 text-right">
                <input type="submit" value="Salva" class="text-big"/>
            </div>
        </div>
        </center>
    </div>
    <% } %>
</asp:Content>

