<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LoginModel>" %>

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

<% using (Html.BeginForm("Login", "Account", FormMethod.Post, new { id = "loginForm" }))
   { %>
    <fieldset>
        <legend><%= UIHelper.T("txt.login")%></legend>
        
        <% if (Model.HasError) { %>
                <div class="errorbox"><%= Model.Error %></div>
        <% } %>
        <input type="hidden" name="redirectUrl" value="<%= Model.RedirectUrl %>" />
        <p>
            <label>Email*</label><br />
            <input type="text" class="" name="email" />
        </p>
        <p>
            <label>Password*</label><br />
            <input type="password" class="" name="password" />
        </p>
        <p><input type="submit" value="Login" /></p>
    </fieldset>
<% } %>