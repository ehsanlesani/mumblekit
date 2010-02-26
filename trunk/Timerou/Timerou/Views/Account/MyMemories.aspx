<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../Scripts/MyMemoriesManager.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        var ONE_MORE_TIME = '<%= UIHelper.T("msg.oneMoreTime") %>';
    
        $(document).ready(function() {
            var manager = new MyMemoriesManager();
            manager.initialize();
        });
    </script>
    
    <style type="text/css">
        #userMediasContainer .avatar a:link, #userMediasContainer .avatar a:visited
        {
            display: block;
            height: 50px;
            width: 50px;
            border: solid 1px gray;
        }
        
        #userMediasContainer .avatar a:hover
        {
            display: block;
            height: 50px;
            width: 50px;
            border: solid 1px red;
        }
        
        #userMediasContainer .avatar img 
        {
            border: 0px;
            height: 50px;
            width: 50px;
        }
        
        #userMediasContainer .title
        {
            
        }
        
        #userMediasContainer .address
        {
            font-style: italic;
        }
        
        #userMediasContainer .year
        {
            font-weight: bold;
            color: #E80005;
        }
        
        #userMediasContainer
        {
            border-spacing: 3px;            
        }
    </style>
    
    <h2>MyMemories</h2>
    
    <div class="filters box">
        <form action="#" id="searchForm">
            <input type="text" id="keyword" />
            <select id="year">
                <option>(All)</option>
                <option>2010</option>
            </select>
            <input type="submit" value="<%= UIHelper.T("txt.search") %>" /> <img src="<%= UriHelper.Images %>ajaxLoading.gif" alt="loading" id="loading" class="hidden" />
        </form>
    </div>
    
    <div class="box">
        <table id="userMediasContainer"></table>  
        <div>
            <a href="javascript:;" id="backButton">back</a> | <a href="javascript:;" id="forwardButton">forward</a>
        </div>          
    </div>

<div style="display: none;" id="templates">
    <table>
        <tr id="mediaRowTemplate">
            <td class="avatar">
                <a href="javascript:;"><img src='<%= UriHelper.Images %>noPhoto.png' id="avatarImage" alt="missing" /></a>
            </td>
            <td>
                <span class="year" id="mediaYear">2010</span> <span class="title" id="title">Matera citta' d'arte</span><br />
                <span class="address" id="address">Via e. de martino, 75100 Matera, Italia</span><br />
                <span><%= UIHelper.T("msg.sharedOn") %> 12/12/1222</span> 
                [ <a href="javascript:;" id="editButton"><%= UIHelper.T("txt.edit") %></a> | <a href="javascript:;" id="deleteButton"><%= UIHelper.T("txt.delete") %></a> ]
            </td>
        </tr>
    </table>
</div>

</asp:Content>
