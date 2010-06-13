<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<MailingList>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">SendMailToOne</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm())
       { %>
    <div class="module">
        <h5>Invio una mail a <%=Model.Surname%> <%=Model.Name%></h5>    
        <hr />
        <div class="module-section">
            <div class="w95">
                <p> Stai per inviare una email a <strong><%=Model.Email%></strong></p>
            </div>
        </div>
        <div class="module-section">
            <div class="w25 text-right">
                <label for="Subject">Oggetto:</label>
            </div>
            <div class="w70"><%=Html.TextBox("Subject")%></div>
        </div>
        <div class="module-section">
            <div class="w25"></div>
            <div class="w70 text-bold text-underline">
                <%=Html.ValidationMessage("Subject")%>
            </div>
        </div>
        <div class="module-section">
            <div class="w25 text-right">
                <label for="Message">Messaggio:</label>
            </div>
            <div class="w70">
            <%=
                Html.TextArea("Message", System.IO.File.ReadAllText(Server.MapPath("~/Views/MailingList/MailTemplate.html"), Encoding.ASCII), new { rows = "4", cols = "10" })
            %>
            </div>
        </div>
        <div class="module-section">
            <div class="w25"></div>
            <div class="w70 text-bold text-underline">
                <%=Html.ValidationMessage("Message")%>
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