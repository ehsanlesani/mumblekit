<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

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