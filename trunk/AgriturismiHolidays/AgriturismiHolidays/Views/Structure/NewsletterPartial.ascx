<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>


<script type="text/javascript">
    $(document).ready(function() {
        $('#mailingForm').bind("submit", function(event) {
            event.preventDefault();
            var myUrl = "/Mailing.aspx/Iscriviti?usermail=" + $('#usermail').val();
            
            $.ajax({
                type: "GET",

                url: myUrl,

                dataType: "json",

                success: function(data) {
                    if (data.isOnError == false)
                        alert('registrazione avvenuta con successo');
                    else
                        alert('non è stato possibile completare la registrazione');
                },

                error: function(request, status, error) {
                    alert('il server non risponde, non è stato possibile completare la registrazione, riprovare più tardi');
                }
            });
        });
    });
</script>

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
        <% using (Html.BeginForm("Iscriviti", "Mailing", FormMethod.Get, new { id = "mailingForm" }))
           { %>
        <div id="subscription-panel">       
            e-mail                    
            <%= Html.TextBox("usermail", null)%>     
            <input type="image" src="../../Content/Images/arrow-right.png" alt="ok" id="newsletter-arrow" />
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