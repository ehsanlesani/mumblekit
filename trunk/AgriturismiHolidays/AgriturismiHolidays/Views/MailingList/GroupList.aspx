<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MailingListGroup>>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">Lista Gruppi</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%using (Html.BeginForm())
      { %>
    <div class="module">
        <h5>Gruppi</h5>
        <div class="module-section">
            <div class="w95">
                <table class="text-medium">
                    <tr>
                        <th></th>
                        <th>GroupId</th>
                        <th>Name</th>
                    </tr>
                <%  bool b = true;
                    foreach (var item in Model) { %>
                    <tr class="<%=(b = !b) ? "row1" : "row2" %>">                        
                        <td>   
                            <a href="<%=Url.Action("EditGroup", new { GroupID = item.GroupID}) %>">
                                <img src="/Content/Images/Edit.png" alt="Modifica" width="16" height="16" />
                            </a>
                            <a href="<%=Url.Action("DeleteGroup", new { GroupID = item.GroupID}) %>">
                                <img src="/Content/Images/Delete.png" alt="Elimina" width="16" height="16" />
                            </a>
                        </td>
                        <td class="text-center"><%= Html.Encode(item.GroupID)%></td>
                        <td class="text-center"><%= Html.Encode(item.Name)%></td>
                    </tr>
                <% } %>
                </table>            
            </div>
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
    <%} %>
</asp:Content>

