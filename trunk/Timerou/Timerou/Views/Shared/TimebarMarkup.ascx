<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<div id="timebar" class="timebar">
    <a href="javascript:;" class="backButton"></a>
    <div class="mediasContainer"></div>
    <div class="barBegin"></div>
    <div class="bar">
        <div class="pointer"></div>
    </div>
    <div class="barEnd"></div>
    <a href="javascript:;" class="forwardButton"></a>
    <div class="barLoading"><img src="<%= UriHelper.Images %>ajaxLoading.gif" alt="loading..." /></div>
</div>