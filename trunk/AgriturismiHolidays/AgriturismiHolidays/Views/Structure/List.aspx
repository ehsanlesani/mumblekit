<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<StructureListViewModel>" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ViewModels" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">

    <div id="col-sx" class="span-7">
        <% Html.RenderPartial("NewsletterPartial"); %>
        <% 
            if (!Model.ErrorThrown)
            {
                if (Model.StaticPages != null)
                    Html.RenderPartial("SideStaticContent", Model.StaticPages); 
        %>
    </div>
    <div id="col-dx" class="span-17 last">        
        <div id="section-info">
            <img src="../../Content/Images/arrow-bottom-right.png" alt="sezione:" class="section-arrow" />
            <span class="section-title"><%=Model.SectionName%></span>
        </div>
        <div id="control" style="text-align:right">
            <% Html.BeginForm("List", "Structure"); %>
            <input type="hidden" name="Category" value="<%=ViewData["RawCategoryValue"]%>" />
            <table>            
            <tr>    
                <td align="right">Filtro geografico:</td>    
                <td><%=Html.DropDownList("RegionItems", ViewData["RegionItems"] as IEnumerable<SelectListItem>, new { @class = "filters" })%></td>
                <td colspan="3">
                    <select id="ProvinceItems" name="ProvinceItems" class="filters">
                        <option value=""> - provincia - </option>
                    </select>
                </td>
                <td colspan="3">
                    <select id="MunicipalityItems" name="MunicipalityItems" class="filters">
                        <option value=""> - comune - </option>
                    </select>
                </td>
                <td><input id="doAccommodationSearch" title="cerca" type="submit" value="cerca" /></td>
            </tr>            
            </table>
            <% Html.EndForm(); %>
        </div>
        
        <%             
            if (Model.Accommodations != null)
            {
                Html.RenderPartial("ListPartial", Model.Accommodations);
        %>
        
        <div class="paging">
        <%        
            for (int i = 0; i <= Model.Pages; i++)
            {
                string className = (Model.ActualPage != i) ? "page" : "actualPage";
                var actionLnk = Html.ActionLink((i + 1).ToString(), "List", new { category = Model.SectionName.Replace(" ", "_"), toSkip = i }, new { @class = className });
                Response.Write(actionLnk);
            }                       
        %>
        </div>
        <% 
            }
                %>
      </div>
      <%
            }
            else 
            {
                %>
                <div id="col-dx" class="span-17 last">
                    <div id="section-info">
                        <img src="../../Content/Images/arrow-bottom-right.png" alt="sezione:" class="section-arrow" />
                        <span class="section-title">Errore:</span>
                        <span class="section-name"><%=Model.ErrorMessage%></span> 
                    </div>
                    <div class="paging"></div>
                </div>
                <%
            }
                            
        %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" media="all" type="text/css" href="<%=ResolveUrl("~/Content/Css/Newsletter.css") %>" />
    <style type="text/css">
        select.filters 
        {
            width:140px;    
        }
    </style>
    <script src="<%=ResolveUrl("~/Content/JS/combo.js")%>" type="text/javascript"></script>
    <script type="text/javascript">
    
        $(document).ready(function() {
            var selection = new HierarchicalSelection();
            selection.registerSelect("RegionItems", "ProvinceItems", "id", "/SelectValues.aspx/Provinces", function() { selection.clearChild("select[name='MunicipalityItems']"); });
            selection.registerSelect("ProvinceItems", "MunicipalityItems", "id", "/SelectValues.aspx/Municipalities", function() { });

            $('select[name="RegionItems"]').change(function() {

                $('select[name="ProvinceItems"]').effect("highlight", { color: '#BC161B' }, 1000);
            });

            $('select[name="ProvinceItems"]').change(function() {

                $('select[name="MunicipalityItems"]').effect("highlight", { color: '#BC161B' }, 1000);
            });
        });
        
    </script>
</asp:Content>
