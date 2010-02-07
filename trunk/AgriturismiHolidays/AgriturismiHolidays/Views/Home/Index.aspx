<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/HomePage.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Mumble.Web.StarterKit.Models.ExtPartial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div id="leftside" class="column span-8">                     
    <img src="../../Content/Images/findApartment-title.png" alt="trova il tuo alloggio!!" />
    <div id="mapa">
        <img alt="Mappa dell'Italia"  src="../../Content/Images/Map/mapaitaly.jpg" usemap="#Map" width="296" height="348" id="italyMap">
      <map name="Map" id="Map">
        <area shape="poly" alt="" coords="13,52,10,52,5,44,5,42,9,39,24,37,30,39,30,48,20,49" nohref href="http://annunci.ebay.it/annunci-valle-d-aosta/" alt="Valle d'Aosta" onMouseOver="m_over('p_285212672');" onMouseOut="m_out('p_285212672')" tabindex="-1" />
        <area shape="poly" alt="" coords="13,54,7,64,2,64,1,68,6,73,9,75,9,80,8,90,9,93,12,95,17,95,26,99,32,99,39,84,51,84,56,81,61,79,61,75,55,67,52,67,46,60,49,56,53,55,48,41,51,34,42,23,36,28,35,34,32,37,31,48" nohref href="http://annunci.ebay.it/annunci-piemonte/" alt="Piemonte" onMouseOver="m_over('p_167772160');" onMouseOut="m_out('p_167772160')" tabindex="-1" />
        <area shape="poly" alt="" coords="51,34,56,41,60,41,60,36,70,21,74,25,82,24,86,26,87,21,85,19,89,15,95,22,95,38,97,41,102,42,103,45,99,49,100,57,112,66,118,70,117,71,115,72,88,68,69,66,67,71,67,79,64,80,62,77,62,73,57,68,53,66,49,62,49,57,55,56,50,44" nohref href="http://annunci.ebay.it/annunci-lombardia/" alt="Lombardia" onMouseOver="m_over('p_134217728');" onMouseOut="m_out('p_134217728')" tabindex="-1" />
        <area shape="poly" alt="" coords="96,23,98,20,92,12,95,7,103,9,108,9,112,4,114,2,125,2,135,0,139,5,144,10,146,12,142,14,137,15,136,13,135,15,128,22,129,25,130,26,129,30,124,35,119,35,114,40,113,43,108,44,103,43,101,40,99,40,96,35,96,29" nohref href="http://annunci.ebay.it/annunci-trentino-alto-adige/" alt="Trentino Alto Adige" onMouseOver="m_over('p_251658240');" onMouseOut="m_out('p_251658240')" tabindex="-1" />
        <area shape="poly" alt="" coords="144,13,151,14,152,16,152,19,144,24,143,29,145,31,145,35,146,39,150,41,152,42,156,40,158,42,159,45,159,47,151,52,148,51,144,51,140,52,140,55,139,61,140,62,145,69,145,71,144,72,139,70,126,70,121,70,117,67,102,57,101,54,100,49,104,45,113,44,116,39,122,35,126,36,130,30,132,26,129,23,131,19,136,16" nohref href="http://annunci.ebay.it/annunci-veneto/" alt="Veneto" onMouseOver="m_over('p_301989888');" onMouseOut="m_out('p_301989888')" tabindex="-1" />
        <area shape="poly" alt="" coords="153,17,158,15,175,18,168,24,169,29,171,29,174,31,171,35,173,36,173,40,171,45,162,45,159,45,159,41,157,39,153,40,152,41,146,36,146,33,146,30,145,27,145,24" nohref href="http://annunci.ebay.it/annunci-friuli-venezia-giulia/" alt="Friuli Venezia Giulia" onMouseOver="m_over('p_83886080');" onMouseOut="m_out('p_83886080')" tabindex="-1" />
        <area shape="poly" alt="" coords="27,100,23,105,23,108,27,108,34,106,36,103,39,100,41,96,50,91,54,88,60,89,63,92,71,94,75,97,79,99,83,101,83,99,70,88,69,83,65,81,62,81,57,81,54,85,42,85,40,85,33,99" nohref href="http://annunci.ebay.it/annunci-liguria/" alt="Liguria" onMouseOver="m_over('p_117440512');" onMouseOut="m_out('p_117440512')" tabindex="-1" />
        <area shape="poly" alt="" coords="68,69,71,66,112,72,123,72,141,71,143,73,141,85,142,91,152,103,153,106,150,106,142,103,138,105,136,108,135,109,120,94,113,98,110,97,99,97,82,87,71,87,68,80,67,71,67,70" nohref href="http://annunci.ebay.it/annunci-emilia-romagna/" alt="Emilia Romagna" onMouseOver="m_over('p_67108864');" onMouseOut="m_out('p_67108864')" tabindex="-1" />
        <area shape="poly" alt="" coords="72,89,90,104,97,125,98,139,109,145,112,149,112,154,120,155,124,155,124,149,127,148,128,144,130,141,132,140,131,131,137,125,134,122,138,117,138,114,123,101,119,96,116,99,113,100,105,100,100,99,82,89" nohref href="http://annunci.ebay.it/annunci-toscana/" alt="Toscana" onMouseOver="m_over('p_234881024');" onMouseOut="m_out('p_234881024')" tabindex="-1" />

        <area shape="poly" alt="" coords="136,110,145,119,148,121,153,119,157,126,157,136,158,138,165,139,166,144,171,144,181,139,172,116,154,105,152,107,142,104" nohref href="http://annunci.ebay.it/annunci-marche/" alt="Marche" onMouseOver="m_over('p_150994944');" onMouseOut="m_out('p_150994944')" tabindex="-1" />
        <area shape="poly" alt="" coords="140,116,136,122,138,126,133,134,133,145,135,147,140,149,141,153,146,157,157,148,164,146,164,140,157,139,155,127,151,121,148,122" nohref href="http://annunci.ebay.it/annunci-umbria/" alt="Umbria" onMouseOver="m_over('p_268435456');" onMouseOut="m_out('p_268435456')" tabindex="-1" />
        <area shape="poly" alt="" coords="172,143,182,140,202,166,202,169,196,175,194,173,189,173,188,177,187,179,179,176,171,176,169,172,167,170,162,166,162,164,169,164,162,155,164,154,172,150,172,145" nohref href="http://annunci.ebay.it/annunci-abruzzo/" alt="Abruzzo" onMouseOver="m_over('p_16777216');" onMouseOut="m_out('p_16777216')" tabindex="-1" />
        <area shape="poly" alt="" coords="123,156,131,141,133,147,138,149,140,154,146,157,150,154,155,151,158,149,167,145,171,146,171,149,162,154,161,156,163,158,167,162,167,164,160,164,160,167,170,176,174,177,178,177,183,181,184,185,184,187,181,188,181,191,179,194,177,195,173,195,168,193,163,193,162,194,152,188" nohref href="http://annunci.ebay.it/annunci-lazio/" alt="Lazio" onMouseOver="m_over('p_100663296');" onMouseOut="m_out('p_100663296')" tabindex="-1" />
        <area shape="poly" alt="" coords="184,183,185,180,190,179,191,174,195,175,195,177,204,169,211,173,213,173,213,179,210,181,208,183,208,187,202,189,192,189,187,187,187,190,184,189,182,189,185,185" nohref href="http://annunci.ebay.it/annunci-molise/" alt="Molise" onMouseOver="m_over('p_335544320');" onMouseOut="m_out('p_335544320')" tabindex="-1" />
        <area shape="poly" alt="" coords="213,173,236,174,237,176,235,178,231,182,231,184,283,214,295,227,295,241,294,242,291,241,279,226,272,226,262,219,257,221,249,211,232,201,222,200,210,189,209,182,213,180,214,173,214,173,214,173" nohref href="http://annunci.ebay.it/annunci-puglia/" alt="Puglia" onMouseOver="m_over('p_184549376');" onMouseOut="m_out('p_184549376')" tabindex="-1" />
        <area shape="poly" alt="" coords="221,201,219,208,221,211,223,218,226,223,230,228,230,230,226,233,226,235,229,237,232,238,234,236,236,238,237,239,241,239,244,238,244,232,254,222,247,211,231,202" nohref href="http://annunci.ebay.it/annunci-basilicata/" alt="Basilicata" onMouseOver="m_over('p_318767104');" onMouseOut="m_out('p_318767104')" tabindex="-1" />
        <area shape="poly" alt="" coords="183,190,193,190,207,189,212,192,219,198,220,201,219,206,217,209,220,213,221,218,224,222,227,225,228,228,228,230,225,232,220,233,216,234,208,226,208,220,203,214,195,216,193,215,195,212,192,208,186,208,181,197,182,191" nohref href="http://annunci.ebay.it/annunci-campania/" alt="Campania" onMouseOver="m_over('p_50331648');" onMouseOut="m_out('p_50331648')" tabindex="-1" />
        <area shape="poly" alt="" coords="229,239,230,246,238,269,240,275,239,277,232,280,232,287,231,290,227,296,226,298,231,304,234,305,247,287,250,276,251,274,262,272,263,266,262,256,247,245,247,243,249,230,245,232,244,239,239,240,234,238" nohref href="http://annunci.ebay.it/annunci-calabria/" alt="Calabria" onMouseOver="m_over('p_33554432');" onMouseOut="m_out('p_33554432')" tabindex="-1" />

        <area shape="poly" alt="" coords="153,297,161,300,161,298,166,296,169,299,171,300,174,303,202,300,205,298,211,298,215,296,223,295,211,321,212,325,214,328,214,333,214,339,212,346,210,347,198,344,193,335,151,316,146,311,146,306" nohref href="http://annunci.ebay.it/annunci-sicilia/" alt="Sicilia" onMouseOver="m_over('p_218103808');" onMouseOut="m_out('p_218103808')" tabindex="-1" />
        <area shape="poly" alt="" coords="51,205,61,197,62,195,72,199,74,202,73,204,77,208,78,210,78,225,76,230,76,234,75,254,72,265,63,264,54,273,49,273,45,264,45,247,47,245,47,239,44,238,44,233,44,224,41,218,38,213,38,209,39,206,43,207,46,208" nohref href="http://annunci.ebay.it/annunci-sardegna/" alt="Sardegna" onMouseOver="m_over('p_201326592');" onMouseOut="m_out('p_201326592')" tabindex="-1" />
      </map>
      
        <div id="regionName">
            <p class="paddingtop5" id="p_16777216"> <a href="http://annunci.ebay.it/annunci-abruzzo/" class="link" onMouseOver="m_over('p_16777216');" onMouseOut="m_out('p_16777216')" > Abruzzo </a> </p>

            <p class="paddingtop5" id="p_318767104"> <a href="http://annunci.ebay.it/annunci-basilicata/" class="link" onMouseOver="m_over('p_318767104');" onMouseOut="m_out('p_318767104')" > Basilicata </a> </p>
            <p class="paddingtop5" id="p_33554432"> <a href="http://annunci.ebay.it/annunci-calabria/" class="link" onMouseOver="m_over('p_33554432');" onMouseOut="m_out('p_33554432')" > Calabria </a> </p>
            <p class="paddingtop5" id="p_50331648"> <a href="http://annunci.ebay.it/annunci-campania/" class="link" onMouseOver="m_over('p_50331648');" onMouseOut="m_out('p_50331648')" > Campania </a> </p>

            <p class="paddingtop5" id="p_67108864"> <a href="http://annunci.ebay.it/annunci-emilia-romagna/" class="link" onMouseOver="m_over('p_67108864');" onMouseOut="m_out('p_67108864')" > Emilia Romagna </a> </p>
            <p class="paddingtop5" id="p_83886080"> <a href="http://annunci.ebay.it/annunci-friuli-venezia-giulia/" class="link" onMouseOver="m_over('p_83886080');" onMouseOut="m_out('p_83886080')" > Friuli Venezia Giulia </a> </p>
            <p class="paddingtop5" id="p_100663296"> <a href="http://annunci.ebay.it/annunci-lazio/" class="link" onMouseOver="m_over('p_100663296');" onMouseOut="m_out('p_100663296')" > Lazio </a> </p>

            <p class="paddingtop5" id="p_117440512"> <a href="http://annunci.ebay.it/annunci-liguria/" class="link" onMouseOver="m_over('p_117440512');" onMouseOut="m_out('p_117440512')" > Liguria </a> </p>
            <p class="paddingtop5" id="p_134217728"> <a href="http://annunci.ebay.it/annunci-lombardia/" class="link" onMouseOver="m_over('p_134217728');" onMouseOut="m_out('p_134217728')" > Lombardia </a> </p>
            <p class="paddingtop5" id="p_150994944"> <a href="http://annunci.ebay.it/annunci-marche/" class="link" onMouseOver="m_over('p_150994944');" onMouseOut="m_out('p_150994944')" > Marche </a> </p>

            <p class="paddingtop5" id="p_335544320"> <a href="http://annunci.ebay.it/annunci-molise/" class="link" onMouseOver="m_over('p_335544320');" onMouseOut="m_out('p_335544320')" > Molise </a> </p>
            <p class="paddingtop5" id="p_167772160"> <a href="http://annunci.ebay.it/annunci-piemonte/" class="link" onMouseOver="m_over('p_167772160');" onMouseOut="m_out('p_167772160')" > Piemonte </a> </p>
            <p class="paddingtop5" id="p_184549376"> <a href="http://annunci.ebay.it/annunci-puglia/" class="link" onMouseOver="m_over('p_184549376');" onMouseOut="m_out('p_184549376')" > Puglia </a> </p>

            <p class="paddingtop5" id="p_201326592"> <a href="http://annunci.ebay.it/annunci-sardegna/" class="link" onMouseOver="m_over('p_201326592');" onMouseOut="m_out('p_201326592')" > Sardegna </a> </p>
            <p class="paddingtop5" id="p_218103808"> <a href="http://annunci.ebay.it/annunci-sicilia/" class="link" onMouseOver="m_over('p_218103808');" onMouseOut="m_out('p_218103808')" > Sicilia </a> </p>
            <p class="paddingtop5" id="p_234881024"> <a href="http://annunci.ebay.it/annunci-toscana/" class="link" onMouseOver="m_over('p_234881024');" onMouseOut="m_out('p_234881024')" > Toscana </a> </p>

            <p class="paddingtop5" id="p_251658240"> <a href="http://annunci.ebay.it/annunci-trentino-alto-adige/" class="link" onMouseOver="m_over('p_251658240');" onMouseOut="m_out('p_251658240')" > Trentino Alto Adige </a> </p>
            <p class="paddingtop5" id="p_268435456"> <a href="http://annunci.ebay.it/annunci-umbria/" class="link" onMouseOver="m_over('p_268435456');" onMouseOut="m_out('p_268435456')" > Umbria </a> </p>
            <p class="paddingtop5" id="p_285212672"> <a href="http://annunci.ebay.it/annunci-valle-d-aosta/" class="link" onMouseOver="m_over('p_285212672');" onMouseOut="m_out('p_285212672')" > Valle d'Aosta </a> </p>

            <p class="paddingtop5" id="p_301989888"> <a href="http://annunci.ebay.it/annunci-veneto/" class="link" onMouseOver="m_over('p_301989888');" onMouseOut="m_out('p_301989888')" > Veneto</a></p>
        </div>
    </div>
</div>
<div id="centerside" class="column span-8">
    <div id="findApartment">
        <% using (Html.BeginForm()){ %> 
        <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="align-right bold">Destinazione:</td>
            <td>
                <% if (ViewData["RegionItems"] != null) { } %>
                <%//Html.DropDownList("RegionItems")%>                
            </td>
        </tr>    
        <tr>
            <td class="align-right bold">Dal:</td>                        
            <td><input type="text" class="datepicker" /></td>
        </tr>
        <tr>
            <td class="align-right bold">Al:</td>
            <td><input type="text" class="datepicker" /></td>
        </tr>
        <tr>
            <td class="align-right bold">Persone:</td>
            <td>
            <select>
                <option>2 persone</option>
            </select>
            </td>
        </tr>
        <tr>
            <td class="align-right bold">Camere:</td>
            <td>
            <select>
                <option>1 camera</option>
            </select>
            </td>
        </tr>
        <tr>
            <td class="align-right"><input type="button" value="cerca" /></td>
            <td></td>
        </tr>        
        </table>  
        <% } %>                  
    </div>                
</div>
<div id="rightside" class="column span-8 last">
    <div id="border-left">                    
    </div>
    <div id="announced">
        <img src="../../Content/Images/announced-by.png" alt="segnalati da noi" class="section-title" />
        <%
            if (ViewData["Showcase"] != null) 
            {
                IEnumerable<Accommodation> alist = ViewData["Showcase"] as IEnumerable<Accommodation>;

                // Quante belle if :P
                if (alist != null) 
                {
                    foreach (Accommodation a in alist) 
                    {
                        if (!a.Attachments.IsLoaded)
                            a.Attachments.Load();
                        
                        if (a.Attachments.Count > 0)
                        {
                            var img = a.Attachments.ElementAt<Attachment>(0);               
                        %>
                                <a href="/Public/<%=img.Path %>.jpg" title="<%=a.Name%>">
                                    <img src="/Public/<%=img.Path %>_lil.jpg" alt="<%=a.Name%>" />
                                </a>
                        <%  }
                            else 
                            {   
                        %>
                                <img src="<%=ResolveUrl("~/Content/Images/no_picture.png") %>" alt="<%=a.Name%>" id="structure-main-pic" style="border:none;" />         
                        <%  }
                    }
                }                                
            }  
        %>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
