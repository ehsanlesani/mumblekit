<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LoginModel>" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>

<script type="text/javascript">
    $(document).ready(function () {
        $("#loginForm").validate({
            rules: {
                email: { required: true, email: true },
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
    AccountManager manager = ViewData["AccountManager"] as AccountManager;

    if (!manager.HasLoggedUser)
    {
        using (Html.BeginForm("Login", "Account", FormMethod.Post, new { id = "loginForm" }))
        { 
           %>   
        <input type="hidden" name="redirectUrl" value="<%= Model.RedirectUrl %>" /
        <table cellpadding="0" cellspacing="0">
        <tr>      
            <% if (Model.HasError)
           { %>
                <td><%= Model.Error%></td>
            <% } %>            
            <td>Email*</td>
            <td><input type="text" class="" name="email" /></td>
            <td>Password*</td>
            <td><input type="password" class="" name="password" /></td>
            <td><input type="image" src="<%=ResolveUrl("~/Content/Images/arrow-right.png") %>" title="entra" /></td>
        </tr>
        </table> 
<% 
    }
    }
    else 
    { 
        %>
        <span><%=Html.ActionLink("logout", "Logout", "Account", new { @class="logout" })%></span>
        <span><%=Html.ActionLink("area privata", "PersonalPage", "Account", new { @class = "logout" })%></span>
        <%
    }
        
%>