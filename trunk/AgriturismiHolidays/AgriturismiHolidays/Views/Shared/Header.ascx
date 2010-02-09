<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<div id="header_logon">    
    <% using (Html.BeginForm())
       { %>                   
    <table border="0" cellpadding="0" cellspacing="0">                                            
    <tr>
        <td>Nome Utente:</td>
        <td><%= Html.TextBox("login-user", null)%></td>
        <td>Password:</td>
        <td><%= Html.Password("login-password", null)%></td>
        <td><input type="image" src="<%=ResolveUrl("~/Content/Images/arrow-right.png") %>" title="entra" /></td>
    </tr>                                                  
    </table>    
    <% } %>            
</div>
