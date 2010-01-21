<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/HomePage.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">

    <div id="col-sx" class="span-7">
        <!-- start roundcorners -->
        <div id="newsletter-container">
          <b class="newsletter">
          <b class="newsletter1"><b></b></b>
          <b class="newsletter2"><b></b></b>
          <b class="newsletter3"></b>
          <b class="newsletter4"></b>
          <b class="newsletter5"></b></b>

          <div class="newsletterfg">                          
            <img src="../../Content/Images/newsletter.png" alt="newsletter" id="newsletter-title" />
            <p id="newsletter-content">
                tieniti sempre aggiornato! <b>iscriviti</b> alla nostra <u>newsletter</u>
                <% using (Html.BeginForm()) { %>
                <div id="subscription-panel">       
                    e-mail                    
                    <%= Html.TextBox("newsletter-textbox", null) %>     
                    <img src="../../Content/Images/arrow-right.png" alt="ok" id="newsletter-arrow" />
                </div>
                <% } %>
            </p>
          </div>

          <b class="newsletter">
          <b class="newsletter5"></b>
          <b class="newsletter4"></b>
          <b class="newsletter3"></b>
          <b class="newsletter2"><b></b></b>
          <b class="newsletter1"><b></b></b></b>
        </div>
        <!-- finish roundcorners -->
    </div>
    <div id="col-dx" class="span-17 last">
        <div id="section-info">
            <img src="../../Content/Images/arrow-bottom-right.png" alt="sezione:" class="section-arrow" />
            <span class="section-title">sezione:</span>
            <span class="section-name"><%=ViewData["SectionName"]%></span> 
        </div>
        <div class="result-item">
            <img src="../../Content/Images/Structures/struttura.jpg" alt="nome struttura" class="item-image" />
            <div class="item-info">
                <p><span class="info-title">descrizione:</span><span class="info-description">questa è la mia descrizione..</span></p>
                <p><span class="info-title">valore:</span><span class="info-description">ciao da me!</span></p>
                <p class="info-btn">entra</p>
            </div>
        </div>
    </div>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" media="all" type="text/css" href="<%=ResolveUrl("~/Content/Css/Newsletter.css") %>" />
</asp:Content>
