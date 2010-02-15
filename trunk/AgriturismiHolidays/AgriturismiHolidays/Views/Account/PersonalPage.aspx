<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">

    <table cellpadding="0" cellspacing="0">
    <tr>
        <td>*Nome</td>
        <td><input type="textbox" name="name" /></td>
    </tr>
    <tr>
        <td>*Descrizione</td>
        <td><textarea name="description" /></td>
    </tr>
    <tr>
        <td>Via</td>
        <td><input type="textbox" name="street" />, Nr<input type="textbox" name="streetnr" size="4" /></td>
    </tr>
    <tr>
        <td>Cap</td>
        <td><input type="textbox" name="cap" /></td>
    </tr>
    <tr>
        <td>Dove Siamo</td>
        <td><textarea name="whereweare" /></td>
    </tr>
    <tr>
        <td>*Email</td>
        <td><input type="textbox" name="email" /></td>
    </tr>
    <tr>
        <td>*Tel</td>
        <td><input type="textbox" name="tel" /></td>
    </tr>
    <tr>
        <td>Fax</td>
        <td><input type="textbox" name="fax" /></td>
    </tr>
    <tr>
        <td>Stelle</td>
        <td><input type="textbox" name="stars" /></td>
    </tr>
    <tr>
        <td colspan="2"><input type="textbox" name="invia" /></td>
    </tr>
    </table>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
