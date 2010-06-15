<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">SendMail</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%  using (Html.BeginForm()) { %>
    <div class="module">
        <h5>Invio email</h5>
        <div class="module-section">
            <div class="w95">
                <p> Invia un messaggio a tutti i contatti presenti nella mailing list.</p>
            </div>
        </div>
        <div class="module-section">
            <div class="w25 text-right">
                <label for="subject">Oggetto:</label>
            </div>
            <div class="w70"><%=Html.TextBox("subject", null, new { style = "width:500px;" })%></div>
        </div>
        <div class="module-section">
            <div class="w25"></div>
            <div class="w70 text-bold text-underline">
                <%=Html.ValidationMessage("subject") %>
            </div>
        </div>
        <div class="module-section">
            <div class="w25 text-right">
                <label for="message">Messaggio:</label>
            </div>
            <div class="w70">            
            <%=
                Html.TextArea("message", System.IO.File.ReadAllText(Server.MapPath("~/Views/MailingList/MailTemplate.html"), Encoding.ASCII), new { rows = "4", cols = "10" })
            %>
            </div>
        </div>
        <div class="module-section">
            <div class="w25"></div>
            <div class="w70 text-bold text-underline">
                <%=Html.ValidationMessage("message") %>
            </div>
        </div>        
        <div class="module-section">
            <div class="w95 text-right">
                <input type="submit" value="Invia" class="text-big"/>
            </div>
        </div>
    </div>
    <% } %>
</asp:Content>
