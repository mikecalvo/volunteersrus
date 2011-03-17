<html>
    <head>
        <title><g:layoutTitle default="Higlands Volunteers" /></title>

        <%-- <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" /> --%>
        <link rel="stylesheet" type="text/css" href="${createLinkTo(dir: 'css', file: 'yahoo-all.css')}" />
        <link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css',file:'signmeup.css')}" />
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />

        <g:layoutHead />

        
        <g:javascript library="prototype" />
        <script type="text/javascript" src="${createLinkTo(dir:'js', file:'yahoo-all.js')}"></script>
        <g:javascript library="application" />
    </head>
    <body class="yui-skin-sam">
        <!--div class="sidebar"-->
        <center>
            <table width="900px" style="padding-bottom: 5px">
                <tr>
                    <td width="100px">
                        <img src="${createLinkTo(dir:'images',file:'logo.gif')}" alt="Edina Highlands Elementary" />
                    </td>
                    <td style="text-align: right">
                        <s:isLoggedIn>
                            Logged in as <s:userName />
                            <s:isSuperUser><br/> <a href="${createLink(controller:'adminUser')}">Manage Users</a>
                            </s:isSuperUser>
                            <br/><g:link controller="admin" action="logout">Logout</g:link>
                        </s:isLoggedIn>
                        <s:isNotLoggedIn><a href="${createLink(controller:'admin')}">Admin Login</a></s:isNotLoggedIn>
                    </td>
                </tr>
                <tr id="breadcrumb">
                    <td colspan="2"><a href="${createLink(controller:'event', action:'available')}">Events</a>
                        <g:if test="${event}">
                            &gt;&nbsp;
                            <g:if test="${detail}">${event.name}</g:if>
                            <g:else>
                                <a href="${createLink(controller:"event", action:"detail", id:event.id)}">${event.name}</a>
                            </g:else>
                        </g:if>
                        <g:if test="${currentCrumb}">&gt;&nbsp; ${currentCrumb}</g:if>
                    </td>
                </tr>
                
                <g:if test="${flash.message}">
                    <tr>
                        <td colspan="2" class="statusMessage">${flash.message}</td>
                    </tr>
                </g:if>
                <g:if test="${flash.error}">
                    <tr>
                        <td colspan="2" class="errorMessage">${flash.error}</td>
                    </tr>
                </g:if>
            </table>




            <g:layoutBody />
        </center>
    </body>
</html>