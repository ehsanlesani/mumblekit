<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<object id="timebar" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="<%= UriHelper.Base %>Swf/Timebar.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#ffffff" />
			<param name="allowScriptAccess" value="sameDomain" />
			<embed src="<%= UriHelper.Base %>Swf/Timebar.swf" quality="high" bgcolor="#ffffff"
				width="100%" height="100%" name="map" align="middle"
				play="true"
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>