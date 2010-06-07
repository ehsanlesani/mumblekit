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
                    relative alle novit&agrave; della pasticceria. Puoi filtrare l'elenco
                    utilizzando uno o pi&ugrave; campi presenti di seguito.
                </p>
            </div>
        </div>
        <div class="module-section">
            <div class="w20"><label for="Name">Nome:</label></div>
            <div class="w30"><input type="text" id="Name" name="Name" value="<%=Request.Params["Name"] %>" /></div>
            <div class="w15 text-center"><label for="Surname">Cognome:</label></div>
            <div class="w30"><input type="text" id="Surname" name="Surname" value="<%=Request.Params["Surname"] %>"/></div>
        </div>
        <div class="module-section">
            <div class="w20"><label for="Phone">Telefono:</label></div>
            <div class="w30"><input type="text" id="Phone" name="Phone" value="<%=Request.Params["Phone"] %>"/></div>
            <div class="w15 text-center"><label for="Email">Email:</label></div>
            <div class="w30"><input type="text" id="Email" name="Email" value="<%=Request.Params["Email"] %>"/></div>
        </div>
        <hr />
        <div class="module-section">
            <div class="w70">
                <p class="text-left"> 
                    <img src="/Content/Images/Admin.png" alt="Admin" width="16" height="16" />
                    <%= Html.ActionLink("Admin", "Admin", "Account") %>
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
                        <th>Nome</th>
                        <th>Cognome</th>
                        <th>Email</th>
                        <th>Telefono</th>
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
                        <td><%= Html.Encode(item.Name) %></td>
                        <td><%= Html.Encode(item.Surname) %></td>
                        <td>
                            <a href="<%=Url.Action("SendMailToOne", "MailingList", new { UserID = item.UserID }) %>">
                                <img src="/Content/Images/Email.png" alt="Email" width="16" height="16"/>
                                <%= Html.Encode(item.Email) %>
                            </a>
                            
                        </td>
                        <td><%= Html.Encode(item.Phone) %></td>
                    </tr>
                <% } %>
                </table>            
            </div>
        </div>
    </div>
    <%} %>
</asp:Content>

