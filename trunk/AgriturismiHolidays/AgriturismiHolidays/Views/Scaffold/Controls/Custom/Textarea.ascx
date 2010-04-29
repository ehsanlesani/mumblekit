﻿<%@ Control Language="C#" Inherits="Mumble.Web.StarterKit.Models.Scaffold.Fields.FieldControl" %>
<tr>
    <td class="label">
        <div style="position: relative;">
            <span><%= FieldMetadata.Name %></span>
            <a class="topRight" href="javascript:;" onclick="toggleHtmlEditor('<%= FieldMetadata.Name %>')"><img src="<%= ResolveUrl("~/Content/Images/html.png") %>" style="border: 0;" alt="Html" /></a>
        </div>
    </td>
    <td class="control">
        <textarea style="width:100%; height:250px;" name="<%= FieldMetadata.Name %>" id="<%= FieldMetadata.Name %>"><%= Value %></textarea>
    </td>
</tr>