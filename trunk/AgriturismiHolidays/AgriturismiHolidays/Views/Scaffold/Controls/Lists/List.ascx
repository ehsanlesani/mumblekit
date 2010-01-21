<%@ Control Language="C#" Inherits="Mumble.Web.StarterKit.Models.Scaffold.Lists.ListControl" %>

<table class="list" cellpadding="2" cellspacing="1" border="0" width="100%">
    <thead>
        <tr>
            <% foreach(var column in Configuration.Columns) { %>
                <th><%= column.Header %></th>
            <% } %>
            <th style="width: 1%">&nbsp;</th>
            <th style="width: 1%">&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <% foreach(var row in Data) { %>
        <tr>
            <% foreach(string value in row.Values) { %>
                <td class="content"><%= value %></td>
            <% } %>
            <td class="content"><a href="<%= ResolveUrl(EditAction) %><%= row.Id %>"><img src="../../../../Content/Images/edit.png" border="0" alt="edit" /></a></td>
            <td class="content"><a href="<%= ResolveUrl(DeleteAction) %><%= row.Id %>" onclick="return confirm('Delete?');"><img src="../../../../Content/Images/delete.png" border="0" alt="delete" /></a></td>
        </tr>
        <% } %>        
    </tbody>
</table>
