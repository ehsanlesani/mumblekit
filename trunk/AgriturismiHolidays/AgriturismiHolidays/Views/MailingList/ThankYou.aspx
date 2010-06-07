<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<MailingList>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Registrazione completata
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="module">
        <div class="module-section">
            <div class="w95 text-center">
                <h2>Registrazione completata con successo!</h2>
                <br />
                <p> Grazie <strong><%=Model.Name %> <%=Model.Surname %></strong>. 
                    La registrazione &egrave; stata completata con successo. 
                    Da oggi riceverai sempre informazioni aggiornate sulla
                    pasticceria direttamente sul tuo indirizzo di posta
                    elettronica <%=Model.Email %>
                </p>
            </div>
        </div>
    </div>
</asp:Content>

