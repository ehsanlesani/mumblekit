<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">

    <%
        Html.BeginForm("RegisterAccommodation", "Account", FormMethod.Post, new { id = "registerAccommodationFrm" });
    %>
    <input type="hidden" name="roomCounter" />
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
        <td class="alignment valignTop">*Tipologia</td>
        <td><%=Html.DropDownList("AccommodationType")%></td>
    </tr>
    <tr>
        <td class="alignment valignTop">*Localit�</td>    
        <td>
            <div>
                <%=Html.DropDownList("selectionCity")%>
            </div>
            <div>
                <%
                    if (ViewData["selectionMunicipality"] == null)
                    {                        
                %>
                    <select id="selectionProvince" name="selectionProvince">
                        <option value=""> - provincia - </option>
                    </select>
                <%
                    }
                    else 
                    {
                        Response.Write(Html.DropDownList("selectionProvince"));
                    }   
                %>
            </div>
            <div>
                <%
                    if (ViewData["selectionMunicipality"] == null)
                    {
                %>
                    <select id="selectionMunicipality" name="selectionMunicipality">
                        <option value=""> - comune - </option>
                    </select>
                <%
                    }
                    else
                    {
                        Response.Write(Html.DropDownList("selectionMunicipality"));
                    }
                %>    
            </div>
        </td>
    </tr>
    <tr>
        <td class="alignment valignTop">*Nome Alloggio</td>
        <td><input type="textbox" name="name" value="<%=ViewData["Name"]%>" /></td>
    </tr>
    <tr>
        <td class="alignment valignTop">*Descrizione</td>
        <td><textarea name="description"><%=ViewData["Description"]%></textarea></td>
    </tr>
        <tr>
        <td class="alignment valignTop">*Email</td>
        <td><input type="textbox" name="email" value="<%=ViewData["EMail"]%>" /></td>
    </tr>
    <tr>
        <td class="alignment valignTop">*Tel</td>
        <td><input type="textbox" name="tel" value="<%=ViewData["Tel"]%>" /></td>
    </tr>
    <tr>
        <td class="alignment valignTop">Via</td>
        <td><input type="textbox" name="street" value="<%=ViewData["Street"]%>" /> Nr <input type="textbox" name="streetnr" size="4" value="<%=ViewData["StreetNr"]%>" /></td>
    </tr>
    <tr>
        <td class="alignment valignTop">Cap</td>
        <td><input type="textbox" name="cap" value="<%=ViewData["Cap"]%>" /></td>
    </tr>
    <tr>
        <td class="alignment valignTop">Dove Siamo</td>
        <td><textarea name="whereweare"><%=ViewData["WhereWeAre"]%></textarea></td>
    </tr>
    <tr>
        <td class="alignment valignTop">Fax</td>
        <td><input type="textbox" name="fax" value="<%=ViewData["Fax"]%>" /></td>
    </tr>
    <tr>
        <td class="alignment valignTop">Stelle</td>
        <td><input type="textbox" name="stars" value="<%=ViewData["Stars"]%>" /></td>
    </tr>    
    
    <% Html.RenderPartial("~/Views/Controls/JpegAttachments.ascx"); %>
    
    <tr>
        <td colspan="2">Stanze<input type="image"  name="addRoomBtn" alt="aggiungi stanza" src="../../Content/Images/add.png" class="addOneMore" /></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <div id="roomContainer">
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="alignment"><input type="submit" value="salva dati alloggio" name="invia" /></td>
    </tr>    
    </table>
    <%
        Html.EndForm();  
        
    %>
    
    <div style="display:none" id="templates">
        <table id="templateTbl" style="border:1px dotted #4F2925;">
        <tr>
            <td colspan="2"><input type="image" name="removeRoomBtn" alt="rimuovi stanza" src="../../Content/Images/delete.png" class="addOneMore" /></td>
        </tr>
        <tr>
            <td>tipologia:</td>
            <td><%=Html.DropDownList("NewRoomType")%></td>
        </tr>
        <tr>    
            <td>nome:</td>
            <td><input type="text" name="roomName" /></td>
        </tr>
        <tr>    
            <td>posti:</td>
            <td><input type="text" name="roomPersons" /></td>                    
        </tr>
        <tr>
            <td valign="top"><b>Tariffe</b></td>
            <td>
                <table>
                <% 
                    IEnumerable<PriceListSeason> seasons = ViewData["Seasons"] as IEnumerable<PriceListSeason>; 
                    
                    if(seasons!=null) {
                        
                        foreach(PriceListSeason s in seasons) { 
                %>
                        <tr>
                            <td><%=s.Description%>:</td>
                            <td><input type="text" name="<%=s.Id.ToString()%>" />&nbsp;&euro;</td>
                        </tr>
                
                <%      }                         
                    }
                %>
                </table>
            </td>
        </tr>
        </table>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
<script src="<%=ResolveUrl("~/Content/JS/combo.js")%>" type="text/javascript"></script>
<script type="text/javascript">

    var DomManager = {

        counter: 0,

        fixCloned: function(jqueryObj) {
            var id = jqueryObj.attr('id');
            jqueryObj.attr('id', id + "_" + this.counter);

            this.fixInnerElements(jqueryObj, 'input');
            this.fixInnerElements(jqueryObj, 'select');
        },

        fixInnerElements: function(jqueryObj, elementName) {
            var self = this;

            jqueryObj.find(elementName).each(function() {

                var name = $(this).attr('name');
                $(this).attr('name', name + "_" + self.counter);
            });
        },

        appendTo: function(elementName, jQueryObj) {
            $(elementName).append(jQueryObj);
            this.counter++;
            this.updateDomCounter('input[type="hidden"][name="roomCounter"]');
        },

        updateDomCounter: function(elementName) {
            $(elementName).val(this.counter);
        }
    }


    $(document).ready(function() {
        var selection = new HierarchicalSelection();
        selection.registerSelect("selectionCity", "selectionProvince", "id", "/SelectValues.aspx/Provinces", function() { selection.clearChild("select[name='selectionMunicipality']"); });
        selection.registerSelect("selectionProvince", "selectionMunicipality", "id", "/SelectValues.aspx/Municipalities", function() { });

        $('input[type="image"][name="addRoomBtn"]').click(function(event) {

            var cloneTable = $('table#templateTbl').clone();
            DomManager.fixCloned(cloneTable);
            DomManager.appendTo('div#roomContainer', cloneTable);

            event.preventDefault();
        });
    });
    
</script>
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
    
    td.valignTop 
    {
        vertical-align:top;    
    }
</style>
</asp:Content>

