<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>

<% 
    AccountManager manager = ViewData["AccountManager"] as AccountManager;
    LoginModel login = ViewData["Login"] as LoginModel;

    if (!manager.HasLoggedUser)
    {
        using (Html.BeginForm("Login", "Account", FormMethod.Post, new { id = "loginForm" }))
        { 
           %>   
        <input type="hidden" name="redirectUrl" value="<%= login.RedirectUrl %>" /
        <table cellpadding="0" cellspacing="0">
        <tr>      
            <% if (login.HasError)
           { %>
                <td><%= login.Error%></td>
            <% } %>            
            <td>Email*</td>
            <td><input type="text" class="" name="email" /></td>
            <td>Password*</td>
            <td><input type="password" class="" name="password" /></td>
            <td><input type="image" src="<%=ResolveUrl("~/Content/Images/arrow-right.png") %>" title="entra" /></td>
        </tr>
        </table> 
        
        <script type="text/javascript">
            $(document).ready(function() {
                $("#loginForm").validate({
                    rules: {
                        email: "required",
                        password: "required"
                    },
                    messages: {
                        email: '<%= UIHelper.T("msg.invalidEmail") %>',
                        password: '<%= UIHelper.T("msg.passRequired") %>'
                    }
                });
            });
        </script>
    <% 
        }
    }
    else 
    { 
        %>
        <span><%=Html.ActionLink("logout", "Logout", "Account", null, new { @class="logout" })%></span>
        <span><%=Html.ActionLink("area privata", "PersonalPage", "Account", null, new { @class = "logout" })%></span>
        <%
    }
        
%>