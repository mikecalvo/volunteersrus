<html>
<head>
    <title>Edina Highlands Elementary Volunteer Confirmation</title>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${position && position.filled}">
    <table style="width: 900px; border: 1px solid black" cellpadding="10" cellspacing="0">
        <tr><td class="tableheading">Thank You For Volunteering</td></tr>
        <tr><td>
            <p>You have successfully registered as a volunteer for the ${position.event.name}.
            You will receive an email shortly confirming this registration. Here are the details of your registration.</p>

            <center>
                <table width="400px" style="border: 1px solid black" cellpadding="3" cellspacing="0">
                    <tr><td class="label">Title:</td><td class="value">${position.title}</td></tr>
                    <tr><td class="label">Description:</td><td class="value">${position.description}</td></tr>
                    <tr><td class="label">Date:</td><td class="value">${position.formattedDate}</td></tr>
                    <tr><td class="label">Time Frame:</td><td class="value">${position.formattedTimeFrame}</td></tr>
                    <tr><td class="label">Location:</td><td class="value">${position.location}</td></tr>
                    <g:if test="${position.manager && position.manager.volunteer}">
                        <tr><td class="label">Reporting To:</td><td class="value">${position.manager.volunteer.name}</td></tr>
                    </g:if>

                    <tr><td class="label">Name:</td><td class="value">${position.volunteer.name}</td></tr>
                    <tr><td class="label">Email:</td><td class="value">${position.volunteer.email}</td></tr>
                    <tr><td class="label">Phone:</td><td class="value">${position.volunteer.phone}</td></tr>
                </table>
            </center>
            <p>
                If you have any questions about this position please contact the event coordinator
                <a href="mailto:${position.event.administrator.email}">${position.event.administrator.name}</a> at ${position.event.administrator.phone}.
            </p>
            <p>Thank you for volunteering for the ${position.event.name}</p>
            <p><g:link controller="event" action="detail" id="${position.event.id}">Click here to return to the ${position.event.name}</g:link></p>
        </td>
        </tr>
    </table>
</g:if>
<g:else>
    This position has not been filled yet
    <p><g:link controller="event" action="detail" id="${position.event.id}">Click here to return to the ${position.event.name}</g:link></p>
</g:else>


</body>
</html>