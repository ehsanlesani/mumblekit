<%@ Control Language="C#" Inherits="Mumble.Web.StarterKit.Models.Scaffold.Fields.BooleanFieldControl" %>
<tr><td class="label"><%= FieldMetadata.Name %></td><td class="control"><input type="checkbox" value="true" name="<%= FieldMetadata.Name %>" <%= Checked %> /></td></tr>
