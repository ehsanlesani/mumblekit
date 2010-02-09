<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">

    <%
    
        if (ViewData["Body"] != null) 
        {
            Mumble.Web.StarterKit.Models.ExtPartial.Page p = ViewData["Body"] as Mumble.Web.StarterKit.Models.ExtPartial.Page;
            Response.Write(p.Body);
        }    
        
    %>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
