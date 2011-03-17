<html>
<head>
    <title>Edina Highlands Elementary Donation Confirmation</title>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${itemDonation}">
    <table style="width: 900px; border: 1px solid black" cellpadding="10" cellspacing="0">
        <tr><td class="tableheading">Thank You For Donating</td></tr>
        <tr><td>
            <p>You have successfully registered to donate to ${itemDonation.donation.event.name}.
            You will receive an email shortly confirming this registration. Here are the details of your registration.</p>


            <center>
                <table width="400px" style="border: 1px solid black" cellpadding="3" cellspacing="0">
                    <tr><td class="label">Item:</td><td class="value">${itemDonation.donation.item.name}</td></tr>
                    <tr><td class="label">Description:</td><td class="value">${itemDonation.donation.item.description}</td></tr>
                    <tr><td class="label">Quantity:</td><td class="value">${itemDonation.quantity}</td></tr>

                    <tr><td class="label">Name:</td><td class="value">${itemDonation.donor.name}</td></tr>
                    <tr><td class="label">Email:</td><td class="value">${itemDonation.donor.email}</td></tr>
                    <tr><td class="label">Phone:</td><td class="value">${itemDonation.donor.phone}</td></tr>
                </table>
            </center>
            <p>
                If you have any questions about this item please contact the event coordinator
                <a href="mailto:${itemDonation.donation.event.administrator.email}">${itemDonation.donation.event.administrator.name}</a> at ${itemDonation.donation.event.administrator.phone}.
            </p>
            <p>Thank you for donating to the ${itemDonation.donation.event.name}</p>
            <p><g:link controller="event" action="detail" id="${itemDonation.donation.event.id}" params="[itemsTab:'selected']">Click here to return to the ${itemDonation.donation.event.name}</g:link></p>
            
        </td>
        </tr>
    </table>

</g:if>
<g:else>
    This Donation is not in the system.
</g:else>


</body>
</html>