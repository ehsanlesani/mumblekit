<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="Mumble.Web.StarterKit.Models.Scaffold.Mvc.ScaffoldViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	<%= Scaffolder.CurrentEntity != null ? "Editing " : "Inserting " %> <%= Model.EntityType.Name %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        var htmlEditors = {};

        $(document).ready(function() {
            $(".datepicker").datepicker({
                buttonImage: "/Content/Images/datepicker.png",
                buttonImageOnly: true,
                dateFormat: "dd/mm/yy",
                showOn: "both"
            });

            $(".htmlEditor").each(function(i, el) {
                var id = $(el).attr("id");
                toggleHtmlEditor(id);
            });

            $(".numeric").numeric();
        });

        function toggleHtmlEditor(id) {
            if (htmlEditors[id] != undefined && htmlEditors[id] != null) {
                htmlEditors[id].removeInstance(id);
                htmlEditors[id] = null;
            } 
            else {
                htmlEditors[id] = new nicEditor({ iconsPath: '/Content/JS/nicEdit/nicEditorIcons.gif' }).panelInstance(id);
            }
            
        }
    </script>
    
    <% if(ViewData["Error"] != null) { %>
        <p class="error"><%= ViewData["Error"] %></p>
    <% } %>
    
    <% if(ViewData["Message"] != null) { %>
        <p class="message"><%= ViewData["Message"] %></p>
    <% } %>
    
    <form method="post" action="<%= ResolveUrl(Model.SaveAction) %>">
        <% Scaffolder.Edit(ViewContext, EntityType, Id); %>
    </form>
</asp:Content>
