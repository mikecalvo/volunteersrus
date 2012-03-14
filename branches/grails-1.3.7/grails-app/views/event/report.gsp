<html>
    <head>
        <title>Edina Highlands Event Report</title>
        <meta name="layout" content="main" />
        <script type="text/javascript">
        </script>
    </head>
    <body>
        <g:if test="${flash.message != null}"><div class="statusMessage">${flash.message}</div></g:if>

    <g:form controller="event" action="report" id="${event.id}">

        <div style="width: 100%; text-align: left; padding-bottom: 3px">
            <span style="font-weight: bold; font-size: 18">Positions</span><br>
            Filled: <g:select name="positionWhere" value="${positionWhere}" from="${EventController.positionWheres}"
                              optionKey="key" optionValue="label" />
            <input type="submit" value="Update" />
        </div>
        <table id="volunteers" width="100%" style="border: 1px solid #000000; margin-bottom: 10px" cellspacing="0">
            <thead>
                <th>Position</th><th>Description</th><th>Time</th><th>Date</th><th>Location</th><th>Date Filled</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone</th>
            </thead>
            <tbody>
                <g:each var="p" in="${positions}" status="i">
                        <tr class="${i %2 == 0 ? 'even' : 'odd'}">
                            <td style="text-align: left">${p.title}</td>
                            <td>${p.description}</td>
                            <td style="text-align: center">${p.formattedTimeFrame}</td>
                            <td style="text-align: center">${p.formattedDate}</td>
                            <td style="text-align: center">${p.location}</td>
                            <td style="text-align: center">
                                <g:if test="${p.filledDate}">
                                    <g:formatDate format="yyyy-MM-dd hh:mm a" date="${p.filledDate}"/>
                                </g:if>
                                <g:else>&nbsp;</g:else>
                            </td>
                            <td style="text-align: center">${p.volunteer?.firstName}</td>
                            <td style="text-align: center">${p.volunteer?.lastName}</td>
                            <td style="text-align: center"><a href="mailto:${p.volunteer?.email}">${p.volunteer?.email}</a></td>
                            <td style="text-align: center">${p.volunteer?.phone}</td>
                        </tr>
                </g:each>
            </tbody>
        </table>

        <div style="width: 100%; text-align: left; padding-bottom: 3px">
            <span style="font-weight: bold; font-size: 18">Items</span>
        </div>
        <table id="donors" width="100%" style="border: 1px solid #000000; margin-bottom: 10px">
            <thead>
                <th>Item</th><th>Quantity</th><th>First Name</th> <th>Last Name</th><th>Phone</th><th>Email</th>
            </thead>
            <tbody>
                <g:each var="eventItem" in="${items}">
                    <g:each var="donation" in="${eventItem.donations}">
                            <tr>
                                <td style="width: 20%; text-align: center">${eventItem.item.name}</td>
                                <td style="width: 35%; text-align: center">${donation.quantity}</td>
                                <td style="width: 35%; text-align: center">${donation.donor.firstName}</td>
                                <td style="width: 35%; text-align: center">${donation.donor.lastName}</td>
                                <td style="width: 10%; text-align: center">${donation.donor.phone}</td>
                                <td style="width: 35%; text-align: center">${donation.donor.email}</td>
                            </tr>
                    </g:each>
                </g:each>
            </tbody>
        </table>

        <div style="width: 100%; text-align: left; padding-bottom: 3px">
            <span style="font-weight: bold; font-size: 18">Do Not Call List</span>
        </div>
        <table id="nonParticipants" width="100%" style="border: 1px solid #000000">
            <thead>
                <th>Last Name</th><th>First Name</th><th>Date</th>
            </thead>
            <tbody>
                <g:each var="n" in="${nonParticipants}">
                    <tr>
                        <td style="width: 20%; text-align: center">${n.lastName}</td>
                        <td style="width: 35%; text-align: center">${n.firstName}</td>
                        <td style="width: 10%; text-align: center"> <g:formatDate format="MM/dd/yyyy hh:mm a" date="${n.registrationDate}"/></td>
                    </tr>
                </g:each>
            </tbody>
        </table>

        <g:each in="${event.details.sort {it.displayOrder} }" var="detail">
            <br />
            <div style="width: 100%; text-align: left; padding-bottom: 3px">
                <span style="font-weight: bold; font-size: 18">${detail.name}</span>
            </div>
            <table id="detail-${detail.id}" width="100%" style="border: 1px solid #000000">
                <thead>
                    <th>Last Name</th><th>First Name</th><th>Teacher</th><th>Room Number</th><th>Quantity</th>
                </thead>
                <tbody>
                    <g:each var="r" in="${detail.registrations}">
                        <tr>
                            <td style="width: 25%; text-align: center">${r.lastName}</td>
                            <td style="width: 25%; text-align: center">${r.firstName}</td>
                            <td style="width: 25%; text-align: center">${r.teacherName}</td>
                            <td style="width: 15%; text-align: center">${r.roomNumber}</td>
                            <td style="width: 10%; text-align: center">${r.quantity}</td>
                        </tr>
                    </g:each>
                    <tr><td colspan="4" style="text-align: right; font-weight:bold">Total:</td><td style="text-align: center">${detail.total}</td></tr>
                </tbody>
            </table>
        </g:each>

    </g:form>

    </body>
</html>