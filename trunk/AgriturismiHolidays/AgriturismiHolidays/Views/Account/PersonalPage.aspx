<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">

    <%
        Html.BeginForm("RegisterAccommodation", "Account", FormMethod.Post, new { id = "registerAccommodationFrm" });
    %>
    <table cellpadding="0" cellspacing="0">
    <tr>
        <td colspan="2">
            <h3>Anagrafica alloggio</h3>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <span style="color:Red; text-align:center;"><%=ViewData["Error"]%></span>
        </td>
    </tr>
    <tr>
        <td class="alignment">*Nome</td>
        <td><input type="textbox" name="name" /></td>
    </tr>
    <tr>
        <td class="alignment">*Descrizione</td>
        <td><textarea name="description"></textarea></td>
    </tr>
        <tr>
        <td class="alignment">*Email</td>
        <td><input type="textbox" name="email" /></td>
    </tr>
    <tr>
        <td class="alignment">*Tel</td>
        <td><input type="textbox" name="tel" /></td>
    </tr>
    <tr>
        <td class="alignment">Via</td>
        <td><input type="textbox" name="street" /> Nr <input type="textbox" name="streetnr" size="4" /></td>
    </tr>
    <tr>
        <td class="alignment">Cap</td>
        <td><input type="textbox" name="cap" /></td>
    </tr>
    <tr>
        <td class="alignment">Dove Siamo</td>
        <td><textarea name="whereweare"></textarea></td>
    </tr>
    <tr>
        <td class="alignment">Fax</td>
        <td><input type="textbox" name="fax" /></td>
    </tr>
    <tr>
        <td class="alignment">Stelle</td>
        <td><input type="textbox" name="stars" /></td>
    </tr>    
    
    <% Html.RenderPartial("~/Views/Controls/JpegAttachments.ascx"); %>
    
    <tr>
        <td colspan="2" class="alignment"><input type="submit" value="salva dati alloggio" name="invia" /></td>
    </tr>    
    </table>
    <%
        Html.EndForm();  
    %>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    textarea {
        height:100px;
    }
    
    td.alignment {
        text-align:right;
    }
    
    h3 {
        color:#603836;
    }
</style>
</asp:Content>

