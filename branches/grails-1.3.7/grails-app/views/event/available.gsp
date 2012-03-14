<html>
<head>
    <title>Edina Highlands Elementary Sign Up Site</title>
    <meta name="layout" content="main" />
</head>
<body>
<table style="width: 900px; border: 1px solid black" cellpadding="10" cellspacing="0">
    <tr><td class="tableheading">Welcome</td></tr>
    <tr>
        <td >
            <p>Welcome to the Edina Highlands Elementary parent volunteer website.  Select from the upcoming events
            below and view volunteer opportunities.  Thanks for supporting our school.
            </p>
        </td>
    </tr>
    <g:each var="e" in="${events}">
        <tr>
            <td style="text-align: center; font-size: 16pt; padding-bottom: 0px"><a href="${createLink(action:'detail', id:e.id)}">${e.name}</a>

<g:if test="${!e.active}">(Not active - parents cannot see)</g:if>
               <s:isSuperUser>
                 <g:link controller="event" action="delete" id="${e.id}"
                         onclick="return confirm('Are you sure you want to delete this event?')">
                   <img src="${createLinkTo(dir:'images',file:'delete_16x16.gif')}" title="Delete Event" border="0"/></g:link></s:isSuperUser>
            </td>
        </tr>
        <tr><td style="text-align: center; padding-top: 0px">${e.description}</td></tr>
    </g:each>
    <s:isLoggedIn>
        <tr><td style="text-align: right"><g:link controller="event" action="create">Add A New Event</g:link></td></tr>
    </s:isLoggedIn>
</table>
</body>
</html>