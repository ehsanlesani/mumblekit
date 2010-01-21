<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Internal.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
    <div id="badge" class="span-10">
        <img id="structure-main-pic" src="../../Content/Images/Structures/struttura.jpg" alt="struttura" />
        <div class="span-5">
            <p id="badge-title"><span class="lightbrown">Agriturismo di prova</span></p>
            <div id="badge-details">
                <p><span class="lightorange">Indirizzo di prova, 53</span></p>
                <p><span class="lightbrown">Tel.</span><span class="lightorange">0835 50 90 78</span></p>
                <p><span class="lightbrown">Fax.</span><span class="lightorange">0835 50 90 78</span></p>
                <p><span class="lightbrown">email</span><span class="lightorange">info@agriturismi.com</span></p>
            </div>    
        </div>
    </div>
    <div id="structure-description" class="span-13 last">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut suscipit felis. Vestibulum non posuere purus.
        Nam sit amet nibh eget tellus lobortis eleifend sit amet eget eros. Nam ultrices convallis neque eu aliquam. 
        Vivamus vel neque neque, et fringilla ligula.
    </div>    
    <div id="gallery" class="span-24 last">
        <img src="../../Content/Images/Structures/struttura.jpg" alt="struttura" class="gal-image" />
        <img src="../../Content/Images/Structures/struttura.jpg" alt="struttura" class="gal-image" />
        <img src="../../Content/Images/Structures/struttura.jpg" alt="struttura" class="gal-image" />
        <img src="../../Content/Images/Structures/struttura.jpg" alt="struttura" class="gal-image" />
        <img src="../../Content/Images/Structures/struttura.jpg" alt="struttura" class="gal-image" />
    </div>
    <div id="tariffe" class="span-8">        
    </div>
    <div id="dove">
    </div>
    <div id="servizi">
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
