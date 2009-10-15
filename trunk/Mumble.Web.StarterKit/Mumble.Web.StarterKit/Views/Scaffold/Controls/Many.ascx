<%@ Control Language="C#" Inherits="Mumble.Web.StarterKit.Models.Scaffold.Fields.ManyFieldControl" %>
<tr>
    <td class="label"><%= RelationshipMetadata.Name %></td>
    <td class="control">
        <% foreach (SelectListItem item in Items) { %>
            <% if (Values.Contains(item.Value)) { %><%= item.Text %><br /><% } %>
        <% } %>
    </td>
</tr>