﻿<%@ Control Language="C#" Inherits="Mumble.Web.StarterKit.Models.Scaffold.Fields.FieldControl" %>
<tr>
    <td class="label"><%= FieldMetadata.Name %></td>
    <td class="control">
        <input type="text" name="<%= FieldMetadata.Name %>" id="<%= FieldMetadata.Name %>" value="<%= Value %>" class="numeric" />&nbsp;&euro;
    </td>
</tr>