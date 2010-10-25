<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<EditMailingViewModel>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">Modifica contatto</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm()) {%>
    <div class="module">
        <h5>Modifica contatto</h5>
        <hr />
        <div class="module-section">
            <div class="w20 text-bold text-right"><label for="Email">Email:</label></div>
            <div class="w50"><%= Html.TextBox("Email", Model.MailingList.Email) %></div>            
            <div class="w10"><%= Html.ValidationMessage("Email", "*") %></div>
            <div class="w20 text-bold text-right"><label for="Email">Gruppo:</label></div>
            <%
                if (Model.MailingList.MailingListGroups != null)
                {
                    var selectList = new SelectList(Model.MailingListGroups, "GroupId", "Name", Model.MailingList.MailingListGroups.GroupID);                    
            %>            
            <div class="w50"><%= Html.DropDownList("GroupId", selectList)%></div>
            <%
                }
                else
                {
            %>
            <div class="w50">E' necessario assegnare almeno un gruppo in creazione</div>
            <%        
                }    
            %>
            <div class="w10"><%= Html.ValidationMessage("Group", "*") %></div>
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


