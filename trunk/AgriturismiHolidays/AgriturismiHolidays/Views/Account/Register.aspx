<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="RegisterContent" ContentPlaceHolderID="BodyContent" runat="server">

    <script type="text/javascript">
        var BASEURL = '<%=ResolveUrl("~/") %>';
    </script>

     <script type="text/javascript" src="<%=ResolveUrl("~/Content/JS/jquery/jquery.validate.min.js") %>"></script>
     <script type="text/javascript" src="<%=ResolveUrl("~/Content/JS/Account.js") %>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#registerForm").validate({
                rules: {
                    firstName: "required",
                    lastName: "required",
                    email: { email: true, required: true },
                    password: { required: true, minlength: 5 },
                    confirmPassword: { required: true, minlength: 5, equalTo: "#password" }
                },
                messages: {
                    firstName: '<%= UIHelper.T("msg.firstNameRequired") %>',
                    lastName: '<%= UIHelper.T("msg.lastNameRequired") %>',
                    email: '<%= UIHelper.T("msg.invalidEmail") %>',
                    password: { required: '<%= UIHelper.T("msg.passRequired") %>', minlength: '<%= UIHelper.T("msg.min5char") %>' },
                    confirmPassword: { 
                        required: '<%= UIHelper.T("msg.passRequired") %>', 
                        minlength: '<%= UIHelper.T("msg.min5char") %>' , 
                        equalTo: '<%= UIHelper.T("msg.badPasswordConfirm") %>' 
                    }
                },
                submitHandler: function () {
                    new Account().register($("#registerForm").serialize(), $("#resultDiv"), $("#registerLoading"));
                    return false;
                }
            });

        });
    </script>

    <div class="register">
        <% using (Html.BeginForm("Register", "Account", FormMethod.Post, new { id = "registerForm" }))
           { %>
            <fieldset>
                <legend><%= UIHelper.T("txt.register")%></legend>
                <div id="resultDiv"></div> 
                <p>
                    <label><%= UIHelper.T("txt.firstName")%>*</label><br />
                    <input type="text" class="" name="firstName" />
                </p>
                <p>
                    <label><%= UIHelper.T("txt.lastName")%>*</label><br />
                    <input type="text" class="" name="lastName" />
                </p>
                <p>
                    <label>Email*</label><br />
                    <input type="text" class="" name="email" />
                </p>
                <p>
                    <label><%= UIHelper.T("msg.yourPassword")%>*</label><br />
                    <input type="password" class="" name="password" id="password" />
                </p>   
                 <p>
                    <label><%= UIHelper.T("msg.confirmPass")%>*</label><br />
                    <input type="password" class="" name="confirmPassword" />
                </p>                
                <p>
                    <input type="submit" value="<%= UIHelper.T("msg.ok") %>" />
                    <img src="<%= ResolveUrl("~/Content/Images/ajaxLoading.gif") %>" alt="loading" id="registerLoading" class="hide" />
                </p>
            </fieldset>
        <% } %>
    </div>

</asp:Content>
