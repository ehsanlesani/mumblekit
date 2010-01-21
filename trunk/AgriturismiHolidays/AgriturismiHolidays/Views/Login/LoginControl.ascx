<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<% Html.BeginForm("Login", "Login"); %>
<table>
    <tr>
        <td>Email</td>
        <td><%= Html.TextBox("email") %></td>
    </tr>
    <tr>
        <td>Password</td>
        <td><%= Html.Password("password") %></td>
    </tr>
    <tr>
        <td colspan="2">
            <input type="submit" value="Login" />
        </td>
    </tr>
</table>
<% Html.EndForm(); %>