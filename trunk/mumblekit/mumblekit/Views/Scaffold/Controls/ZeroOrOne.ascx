<%@ Control Language="C#" Inherits="Mumble.Web.StarterKit.Models.Scaffold.Fields.ZeroOrOneFieldControl" %>
<tr>
    <td class="label"><%= RelationshipMetadata.Name %></td>
    <td class="control">
        <select name="<%= RelationshipMetadata.Name %>">
        <% foreach (SelectListItem item in Items) { %>
            <option value="<%= item.Value %>" <%= item.Value.Equals(Value) ? "selected='selected'" : "" %>><%= item.Text %></option>
        <% } %>
        </select>
    </td>
</tr>