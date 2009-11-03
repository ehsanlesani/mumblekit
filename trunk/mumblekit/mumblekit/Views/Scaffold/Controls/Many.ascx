<%@ Control Language="C#" Inherits="Mumble.Web.StarterKit.Models.Scaffold.Fields.ManyFieldControl" %>
<tr>
    <td class="label"><%= RelationshipMetadata.Name %></td>
    <td class="control">
        <% foreach (SelectListItem item in Items) { %>
            <input 
                type="checkbox" 
                name="<%= RelationshipMetadata.Name %>" 
                id="<%= item.Value %>" 
                value="<%= item.Value %>"
                <% if (Values.Contains(item.Value)) { %>checked="checked"<% } %>
                />
            <label for="<%= item.Value %>"><%= item.Text %></label><br />
        <% } %>
    </td>
</tr>