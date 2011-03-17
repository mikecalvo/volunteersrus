<html>
    <head>
        <title>Edina Highlands Event Report</title>
        <meta name="layout" content="main" />
        <script type="text/javascript">
        </script>
    </head>
    <body>
        <%-- Error/Info messages --%>
        <g:if test="${flash.message != null}"><div class="statusMessage">${flash.message}</div></g:if>

        <g:form controller="event" action="sendEmail" id="${event.id}" >
        <table width="900px" style="border: 1px solid #000000; margin-bottom: 10px" cellspacing="0">
            <tr><td colspan="2" class="tableheading" style="padding: 10px; ">Send Email to Volunteers/Donors</td></tr>
            <tr><td class="label">To:</td>
                <td style="width:80%">
                    <select name="recipients">
                        <option value="1">All Volunteers</option>
                        <option value="2">All Donors</option>
                        <option value="3">All</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label">Your Name:</td>
                <td><input type="text" name="fromName" size="30" maxlength="30" value="${session.user.name}"/></td>
            </tr>

            <tr>
                <td class="label">Your Email:</td>
                <td><input type="text" name="fromEmail" size="30" maxlength="30" value="${session.user.email}" /></td>
            </tr>



            <tr>
                <td class="label">Subject:</td>
                <td width="400px"><input type="text" name="subject" size="50" maxlength="50"/></td>
            </tr>

            <tr>
                <td class="instructions" colspan="2">
                Type the contents of your message below.  When finished press Send.  A copy of
                your email will be sent to your address.
                </td>
            </tr>

            <tr>
                <td colspan="2" style="padding: 5px 5px 5px 5px">
                    <textarea name="body" rows="10" style="width: 100%"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right"><input type="submit" value="Send" /> </td>
            </tr>

            </g:form>
        </table>
    </body>
</html>