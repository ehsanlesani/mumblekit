<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <script type="text/javascript" src="<%= UriHelper.Scripts %>Account.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            $("#registerForm").validate({
                rules: {
                    firstName: "required",
                    lastName: "required",
                    email: { email: true, required: true },
                    password: { required: true, minlength: 5 },
                    gender: "required",
                    birthday_day: "required",
                    birthday_month: "required",
                    birthday_year: "required",
                    farmID: "required"
                },
                messages: {
                    firstName: '<%= UIHelper.T("msg.firstNameRequried") %>',
                    lastName: '<%= UIHelper.T("msg.lastNameRequried") %>',
                    email: '<%= UIHelper.T("msg.invalidEmail") %>',
                    password: { required: '<%= UIHelper.T("msg.passRequired") %>', minlength: '<%= UIHelper.T("Please enter at least 5 characters") %>' },
                    gender: "",
                    birthday_day: "",
                    birthday_month: "",
                    birthday_year: "",
                    farmID: '<%= UIHelper.T("msg.selectFarm") %>'
                },
                submitHandler: function () {
                    new Account().register($("#registerForm").serialize(), $("#resultDiv"), $("#registerLoading"));
                    return false;
                }
        });

    });
    </script>

    <div class="login span-12 border">
        <% Html.RenderPartial("~/Views/Controls/LoginControl.ascx", new LoginModel()); %>
    </div>
    <div class="register span-12 last">
        <% using (Html.BeginForm("Register", "Account", FormMethod.Post, new { id = "registerForm" }))
           { %>
            <fieldset>
                <legend><%= UIHelper.T("txt.newSheep")%></legend>
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
                    <label><%= UIHelper.T("msg.friendsheepPass")%>*</label><br />
                    <input type="password" class="" name="password" />
                </p>
                <p>
                    <table border="0">
                        <tr>
                            <td>
                                <label><%= UIHelper.T("txt.sex")%>*</label><br />
                                <%= UIHelper.EnumDropDown(typeof(Gender), "gender", null, true, UIHelper.T("Select") + "...") %>
                            </td>
                            <td>
                                <label><%= UIHelper.T("txt.birthday")%></label><br />
                                <%= UIHelper.DayMonthYearSelector("birthday", null)%>
                            </td>
                        </tr>
                    </table>
                </p>
                <p>
                    <label><%= UIHelper.T("msg.selectFarm")%></label><br />
                    <%= Html.DropDownList("farmID", (SelectList)ViewData["Farms"])%>
                </p>
                <p>
                    <input type="submit" value="<%= UIHelper.T("txt.register") %>" />
                    <img src="<%= UriHelper.Images %>ajaxLoading.gif" alt="loading" id="registerLoading" class="hidden" />
                </p>
            </fieldset>
        <% } %>
    </div>
</asp:Content>
