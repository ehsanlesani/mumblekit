<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MailingList>>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">Contatti</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%using (Html.BeginForm())
      { %>
    <div class="module">
        <h5>Contatti</h5>
        <hr />
        <div class="module-section">
            <div class="w95">
                <p> Di seguito &egrave; presente la lista di tutti i contatti
                    a cui, in maniera automatica, vengono inviate mail ed sms
                    relative alle novit&agrave; di expoholidays. Puoi filtrare l'elenco
                    utilizzando uno o pi&ugrave; campi presenti di seguito.
                </p>
            </div>
        </div>
        <div class="module-section">
            <div class="w15 text-center"><label for="Email">Email:</label></div>
            <div class="w30"><input type="text" id="Email" name="Email" value="<%=Request.Params["Email"] %>"/></div>
        </div>
        <hr />
        <div class="module-section">
            <div class="w70">
                <p class="text-left"> 
                    <%= Html.ActionLink("Lista gruppi", "GroupList") %> |
                    <%= Html.ActionLink("Crea un gruppo", "CreateGroup") %> |
                    <img src="/Content/Images/Add.png" alt="Aggiungi news" width="16" height="16" />
                    <%= Html.ActionLink("Inserisci un contatto", "Create") %> |
                    <img src="/Content/Images/Email.png" alt="Invia email" width="16" height="16" />
                    <%= Html.ActionLink("Invia email!", "SendMail") %>
                </p>
            </div>
            <div class="w25 text-right">
                <input type="submit" value="Cerca" class="text-big" />
            </div>
        </div>
        <div class="module-section">
            <div class="w95">
                <table class="text-medium">
                    <tr>
                        <th></th>
                        <th>UserID</th>
                        <th>Email</th>
                    </tr>
                <%  bool b = true;
                    foreach (var item in Model) { %>
                    <tr class="<%=(b = !b) ? "row1" : "row2" %>">
                        <td>   
                            <a href="<%=Url.Action("Edit", new { UserID = item.UserID}) %>">
                                <img src="/Content/Images/Edit.png" alt="Modifica" width="16" height="16" />
                            </a>
                            <a href="<%=Url.Action("Delete", new { UserID = item.UserID}) %>">
                                <img src="/Content/Images/Delete.png" alt="Elimina" width="16" height="16" />
                            </a>
                        </td>
                        <td class="text-center"><%= Html.Encode(item.UserID) %></td>
                        <td>
                            <a href="<%=Url.Action("SendMailToOne", "MailingList", new { UserID = item.UserID }) %>">
                                <img src="/Content/Images/Email.png" alt="Email" width="16" height="16"/>
                                <%= Html.Encode(item.Email) %>
                            </a>
                            
                        </td>
                    </tr>
                <% } %>
                </table>            
            </div>
        </div>
    </div>
    <%} %>
</asp:Content>

