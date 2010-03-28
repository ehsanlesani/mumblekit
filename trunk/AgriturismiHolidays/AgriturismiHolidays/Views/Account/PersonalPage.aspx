<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">

    <%
        List<Room> roomList = ViewData["RoomList"] as List<Room>;
        List<Service> serviceList = ViewData["ServiceList"] as List<Service>;
        
        Html.BeginForm("RegisterAccommodation", "Account", FormMethod.Post, new { id = "registerAccommodationFrm" });
    %>
    <input type="hidden" name="roomTrash" />
    <input type="hidden" name="roomCounter" value="<%= ((roomList != null) ? roomList.Count : 0) %>" />
    <input type="hidden" name="serviceTrash" />
    <input type="hidden" name="serviceCounter" value="<%= ((serviceList != null) ? serviceList.Count : 0) %>" />
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
        <td class="alignment valignTop">*Località</td>    
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
    <tr>
        <td  class="alignment valignTop">Servizi<input type="image" name="addServiceBtn" alt="aggiungi stanza" src="../../Content/Images/add.png" class="addOneMore" /></td>
        <td>
            <div id="serviceContainer">
            <%
                if (serviceList != null) 
                {
                    List<SelectListItem> itemList = ViewData["Services"] as List<SelectListItem>;
                    
                    int i = 0;
                    foreach (Service service in serviceList) 
                    {
                        %>
                        <table id="Table1" style="border:1px dotted #4F2925;">
                        <tr>
                            <td>
                                <input type="image" src="../../Content/Images/delete.png" alt="rimuovi stanza" class="addOneMore removeRoomBtn" />
                            </td>
                            <td>
                            <%
                            Response.Write("<select name=\"service_" + i + "\">");

                            Guid? selected = service.Id;
                            foreach (SelectListItem item in itemList)
                            {
                                var selectedOutput = "";

                                if (selected != null)
                                    if (item.Value.Equals(selected.ToString()))
                                        selectedOutput = "selected=\"selected\"";

                                Response.Write("<option value=\"" + item.Value + "\" " + selectedOutput + ">" + item.Text + "</option>");
                            }

                            Response.Write("<\\select>");    
                            %>
                            </td>
                        </tr>
                        </table>
                    <%
                    }
                }                  
            %>            
            </div>
        </td>
    </tr>  
    
    <% Html.RenderPartial("~/Views/Controls/JpegAttachments.ascx"); %>
    
    <tr>
        <td class="alignment valignTop">Stanze<input type="image"  name="addRoomBtn" alt="aggiungi stanza" src="../../Content/Images/add.png" class="addOneMore" /></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <div id="roomContainer">
            <%
                IEnumerable<PriceListSeason> seasons = ViewData["Seasons"] as IEnumerable<PriceListSeason>;

                if (roomList != null)
                {
                    int i = 0;
                    foreach (Room room in roomList)
                    {
                        var roomType = (from t in room.RoomPriceList select t.PriceListEntries).FirstOrDefault();
                        %>
                        <table id="templateTbl_<%=i%>" style="border:1px dotted #4F2925;">
                        <input type="hidden" name="roomId_<%=i%>" value="<%=room.Id%>" />
                        <tr>
                            <td colspan="2"><input type="image" src="../../Content/Images/delete.png" alt="rimuovi stanza" class="addOneMore removeRoomBtn" /></td>
                        </tr>
                        <tr>
                            <td>tipologia:</td>
                            <td>
                            <%
                List<SelectListItem> itemList = ViewData["NewRoomType"] as List<SelectListItem>;
                if (itemList != null)
                {
                    Response.Write("<select name=\"NewRoomType_" + i + "\">");

                    Guid? selected = null;
                    RoomPriceList r = room.RoomPriceList.FirstOrDefault();
                    if (r != null)
                        selected = r.PriceListEntries.Id;

                    foreach (SelectListItem item in itemList)
                    {
                        var selectedOutput = "";

                        if (selected != null)
                            if (item.Value.Equals(selected.ToString()))
                                selectedOutput = "selected=\"selected\"";

                        Response.Write("<option value=\"" + item.Value + "\" " + selectedOutput + ">" + item.Text + "</option>");
                    }

                    Response.Write("<\\select>");
                }
                            %>
                            </td>
                        </tr>
                        <tr>    
                            <td>nome:</td>
                            <td><input type="text" name="roomName_<%=i%>" value="<%=room.Name%>" /></td>
                        </tr>
                        <tr>    
                            <td>posti:</td>
                            <td><input type="text" name="roomPersons_<%=i%>" value="<%=room.Persons%>" /></td>                    
                        </tr>
                        <tr>
                            <td valign="top"><b>Tariffe</b></td>
                            <td>
                                <table>
                                <% 
                if (seasons != null)
                {
                    foreach (PriceListSeason s in seasons)
                    { 
                                %>
                                        <tr>
                                            <td><%=s.Description%>:</td>
                                            <%                             
                var seasonPrice = (from p in room.RoomPriceList where p.PriceListSeasons.Id.Equals(s.Id) select p.Price.GetValueOrDefault().ToString("#.##")).FirstOrDefault();                                
                                            %>
                                            <td><input type="text" name="<%=s.Id.ToString()%>_<%=i%>" value="<%=seasonPrice%>" />&nbsp;&euro;</td>
                                        </tr>                            
                                <%      
                }
                }
                                %>
                                </table>
                            </td>
                        </tr>
                        </table>     
                <%       
                i++;
                    }
                }
                %>
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
        <table id="templateSrv">
        <tr>
            <td>
                <input type="image" src="../../Content/Images/delete.png" alt="rimuovi servizio" class="addOneMore removeServiceBtn" />
            </td>
            <td><%=Html.DropDownList("Services")%></td>
        </tr>
        </table> 
    
        <table id="templateTbl" style="border:1px dotted #4F2925;">
        <input type="hidden" name="roomId" />
        <tr>
            <td colspan="2"><input type="image" src="../../Content/Images/delete.png" alt="rimuovi stanza" class="addOneMore removeRoomBtn" /></td>
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
                    if(seasons!=null) 
                    {                        
                        foreach(PriceListSeason s in seasons) 
                        { 
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

<%
    List<Room> roomList = ViewData["RoomList"] as List<Room>;
    List<Service> serviceList = ViewData["ServiceList"] as List<Service>;
%>

<script src="<%=ResolveUrl("~/Content/JS/combo.js")%>" type="text/javascript"></script>
<script type="text/javascript">

    Utils = {
    
        syncRemoveBtn: function(prefix, manager) {
            //var self = this;
        
            $('input[type="image"].remove'+ prefix +'Btn').click(function(event) {
            
                manager.removeElement(this);                          
                event.preventDefault();
            });
        }
    }

    DomManager = function(pre) {
        
        this.counter = 0,
        
        this.prefix = pre;
        
        this.container = 'div#'+ pre +'Container';
        
        this.clone = undefined;
    }

    DomManager.prototype = {

        fixCloned: function() {
            var id = this.clone.attr('id');
            this.clone.attr('id', id + "_" + this.counter);

            this.fixInnerElements(this.clone, 'input');
            this.fixInnerElements(this.clone, 'select');
        },

        fixInnerElements: function(jqueryObj, elementName) {
            var self = this;

            jqueryObj.find(elementName).each(function() {

                var name = $(this).attr('name');
                $(this).attr('name', name + "_" + self.counter);
            });
        },
        
        fixAll: function() {
            var self = this;
            
            $(this.container +' > table').each(function(index) {
            
                var domId = $(this).attr('id');
                var items = domId.split("_");
                $(this).attr('id',items[0] +"_"+ index);
                
                $(this).find('input').each(function() {
                    
                    var domId = $(this).attr('name');
                    var items = domId.split("_");
                    $(this).attr('name',items[0] +"_"+ index);
                });
                
                $(this).find('select').each(function() {
                    
                    var domId = $(this).attr('name');
                    var items = domId.split("_");
                    $(this).attr('name',items[0] +"_"+ index);
                });
            });
        },

        appendTo: function() {
            $(this.container).append(this.clone);   
            this.counter++;         
            this.updateDomCounter('input[type="hidden"][name="'+ this.prefix +'Counter"]');
            this.fixCloned();            
        },

        updateDomCounter: function(elementName) {
            $(elementName).val(this.counter);
        },
        
        removeElement: function(domElement) {
            var roomId = $(domElement).parent().parent().parent().parent().find('input[type="hidden"]').val();
            var trash = $('input[type="hidden"][name="'+ this.prefix +'Trash"]');
            var oldVal = trash.val();
            var newVal = (oldVal.length>0) ? oldVal +","+ roomId : roomId;
            trash.val(newVal);
            $(domElement).parent().parent().parent().parent().remove();  
            this.counter--;
            this.updateDomCounter('input[type="hidden"][name="'+ this.prefix +'Counter"]');
            this.fixAll();
        }
    }


    $(document).ready(function() {
        var selection = new HierarchicalSelection();
        selection.registerSelect("selectionCity", "selectionProvince", "id", "/SelectValues.aspx/Provinces", function() { selection.clearChild("select[name='selectionMunicipality']"); });
        selection.registerSelect("selectionProvince", "selectionMunicipality", "id", "/SelectValues.aspx/Municipalities", function() { });

        var roomManager = new DomManager("room");
        roomManager.counter = <%= ((roomList != null) ? roomList.Count : 0) %>;
        $('input[type="image"][name="addRoomBtn"]').click(function(event) {
                
            var cloneTable = $('table#templateTbl').clone(); 
            roomManager.clone = cloneTable;    
            roomManager.appendTo();
            Utils.syncRemoveBtn("Room", roomManager);            
                
            event.preventDefault();
        });      
        Utils.syncRemoveBtn("Room", roomManager);                  
        
        
        var serviceManager = new DomManager("service");
        serviceManager.counter = <%= ((serviceList != null) ? serviceList.Count : 0) %>;
        $('input[type="image"][name="addServiceBtn"]').click(function(event) {
            
            var cloneSelection = $('table#templateSrv').clone();
            serviceManager.clone = cloneSelection;
            serviceManager.appendTo();
            Utils.syncRemoveBtn("Service", serviceManager);
                
            event.preventDefault();
        });
        Utils.syncRemoveBtn("Service", serviceManager);                  
                      
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

