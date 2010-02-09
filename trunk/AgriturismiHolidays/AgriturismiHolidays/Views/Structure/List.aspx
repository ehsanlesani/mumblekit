<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<StructureListViewModel>" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">

    <div id="col-sx" class="span-7">
        <% Html.RenderPartial("NewsletterPartial"); %>
    </div>
    <div id="col-dx" class="span-17 last">
        <div id="section-info">
            <img src="../../Content/Images/arrow-bottom-right.png" alt="sezione:" class="section-arrow" />
            <span class="section-title">sezione:</span>
            <span class="section-name"><%=ViewData.Model.SectionName%></span> 
        </div>
        
        <% Html.RenderPartial("ListPartial", ViewData.Model.Accommodations); %>
        
        <div class="paging">
        <%        
           for(int i=0; i<=Model.Pages; i++)
           {
               string className = (Model.ActualPage != i) ? "page" : "actualPage";                              
               var actionLnk = Html.ActionLink((i+1).ToString(), "List", new { category = Model.SectionName.Replace(" ", "_"), toSkip = i }, new { @class = className });
               Response.Write(actionLnk);
           }            
        %>
        </div>
    </div>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" media="all" type="text/css" href="<%=ResolveUrl("~/Content/Css/Newsletter.css") %>" />
</asp:Content>
