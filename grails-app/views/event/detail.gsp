<html>
    <head>
        <title>Edina Highlands Elementary Event Detail</title>
        <meta name="layout" content="main" />
    </head>
    <body>
        <g:set var="welcomeTab" value="${attachments && !request.getParameter('rolesTab') && !request.getParameter('itemsTab') ? 'selected' : ''}" />
        <g:set var="rolesTab" value="${!welcomeTab && !request.getParameter('rolesTab') && !request.getParameter('itemsTab') ? 'selected' : request.getParameter('rolesTab')}" />
        <g:set var="itemsTab" value="${request.getParameter('itemsTab')}" />
        <g:if test="${request.getParameter('rolesTab') == null}">
        </g:if>

    <s:isLoggedIn>
        <table style="width: 900px; border: 1px solid black; margin-bottom: 5px; padding-bottom: 5px" cellspacing="0">
            <tr><td colspan="7" class="tableheading">Admin Functions</td></tr>
            <tr>
                <td style="padding-left:10px; padding-top: 5px"><g:link controller="event" action="edit" id="${event.id}">Edit Event Details</g:link></td>
                <td style="padding-top: 5px"><a href="${createLink(action:'admin', controller: 'position', id:event.id)}">Edit Positions</a></td>
                <td style="padding-top: 5px"><a href="${createLink(action:'admin', controller: 'item', id:event.id)}">Edit Items</a></td>
                <td style="padding-top: 5px"><a href="${createLink(controller: 'eventDetail',action:'admin', id:event.id)}">Edit Registrations</a></td>
                <td style="padding-top: 5px"><a href="${createLink(controller: 'attachment',action:'admin', id:event.id)}">Edit Attachments</a></td>
                <td style="padding-top: 5px"><g:link controller="event" action="report" id="${event.id}">View Report</g:link></td>
                <td style="padding-top: 5px"><g:link controller="event" action="compose" id="${event.id}">Send Email</g:link></td>
            </tr>
        </table>
    </s:isLoggedIn>

        <table style="width: 900px; border: 1px solid black" cellpadding="10" cellspacing="0">
            <tr><td class="tableheading">${event.name}</td></tr>
            <tr><td class="subheading">
                <g:formatDate format="EEEEEEEE, MM-dd-yyyy" date="${event.date}"/>&nbsp;
                ${event.formattedTimeFrame}
            </td></tr>
            <tr><td>
                <div id="demo" class="yui-navset">
                    <ul class="yui-nav">
                        <g:if test="${attachments}">
                            <li class="${welcomeTab}"><a href="#attachments"><em>Welcome</em></a></li>
                        </g:if>
                        <li class="${rolesTab}"><a href="#roles"><em>Volunteer</em></a></li>
                        <g:if test="${event.donations}">
                            <li class="${itemsTab}"><a href="#items"><em>Donate</em></a></li>
                        </g:if>
                        <g:each in="${details}" var="d">
                            <li><a href="#${d.name}"><em>${d.name}</em></a></li>
                        </g:each>
                    </ul>
                    <div class="yui-content">

                        <g:if test="${attachments}">
                            <div id="attachments">
                                <p>
                                    Welcome to the volunteer and donation signup page for ${event.name}.
                                </p>
                                <p>Please see important information about the event below.</p>
                                <g:each var="a" in="${attachments}">
                                    <div style="width: 95%; border: 1px solid; padding: 10px; text-align: center; font-size: 16; font-weight: bold; margin: 10px">
                                        <a href="<g:createLink controller="attachment" action="view" id="${a.id}" />"
                                                onClick="window.open('','popup','height=500,width=500,scrollbars=no,resizable=yes')" target="popup">${a.name}</a>                                        
                                    </div>
                                </g:each>
                            </div>
                        </g:if>
                        <%-- Roles Tab --%>
                        <div id="roles">
                            <p>
                            The volunteer positions are listed below.  Some positions are specific to the
                            day of the event and for a specific time range.  Only unfilled positions are listed
                            below.  To volunteer, click on the "Volunteer" link on the row you wish to sign up for.
                            You will be prompted to enter your name, email address and phone number.
                            </p>
                            <g:if test="${event.positionInstructions}"><p>${event.positionInstructions}</p></g:if>
                            <p>If you have any questions about a particular position contact
                                <a href="mailto:${event.administrator.email}">${event.administrator.name}</a>
                                at ${event.administrator.phone}                                 
                            </p>
                        <p>If your family is not planning on attending and you do not want to be contacted about volunteering
                            <a href="#" id="optOut" onclick="showOptOutDialog(); return false">provide your information</a>.</p>
                            <table style="width: 100%" cellpadding="10" cellspacing="0">
                                    <tr class="headerRow">
                                        <td>Position</td>
                                        <td>Date</td>
                                        <td style="width: 95px">Timeframe</td>
                                        <td>Location</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                <g:each var="position" in="${positions}" status="i">
                                    <tr class="${i %2 == 0 ? 'even' : 'odd'}">
                                        <td style="width: 50%"><b id="position-${position.id}">${position.title}</b>
                                            <g:if test="${position.description}">
                                                <br>&nbsp;&nbsp;${position.description}
                                            </g:if>
                                        </td>
                                        <td>${position.formattedDate}</td>
                                        <td>${position.formattedTimeFrame}</td>
                                        <td>${position.location}</td>
                                        <td style="vertical-align: middle">
                                            <a href="#" id="volunteer-${position.id}" onclick="showDialog(this)" class="signupLink" >Volunteer</a>
                                        </td>
                                    </tr>
                                </g:each>
                            </table>
                        </div>

                        <g:if test="${event.donations}">
                            <div id="items">
                                <p>Below are items needed for this event.  If you are able to donate an item
                                click on the "Donate" link in the specific row and enter your name, email, phone, and
                                number of items you'd like to contribute.</p>
                                <g:if test="${event.itemInstructions}"><p>${event.itemInstructions}</p></g:if>
                                <p>If you have any questions about a particular item contact
                                    <a href="mailto:${event.administrator.email}">${event.administrator.name}</a>
                                    at ${event.administrator.phone}
                                </p>
                                <table style="width: 100%" cellpadding="5" cellspacing="0">
                                    <tr class="headerRow">
                                        <td style="text-align: left">Item</td><td>Quantity</td><td>&nbsp;</td>
                                    </tr>
                                    <g:each var="eventItem" in="${items}" status="i">
                                        <tr class="${i %2 == 0 ? 'even' : 'odd'}">
                                            <td  style="vertical-align: top"><b id="item-${eventItem.id}">${eventItem.item.name}</b>
                                                <g:if test="${eventItem.item.description}"><br>&nbsp;&nbsp;${eventItem.item.description}</g:if>
                                            </td>
                                            <td style="text-align: center; "> ${eventItem.unsatisfiedAmount}</td>
                                            <td style="vertical-align: middle">
                                                <a href="#" id="donate-${eventItem.id}" onclick="showDialog(this)" class="signupLink" >Donate</a><br />
                                            </td>
                                        </tr>
                                    </g:each>
                                </table>
                            </div>
                        </g:if>

                        <g:each in="${details}" var="d">
                            <div id="${d.name}">
                                <p>
                                    ${d.instructions}                                    
                                </p>

                                <g:form controller="eventDetail" action="register">
                                    <table>
                                        <g:hiddenField name="id" value="${d.id}" />
                                        <g:if test="${d.showFirstName}">
                                            <tr><td class="label">First Name:</td><td class="value"><input type="text" size="30" name="firstName" /></td></tr>
                                        </g:if>
                                        <g:if test="${d.showLastName}">
                                            <tr><td class="label">Last Name:</td><td class="value"><input type="text" size="30" name="lastName" /></td></tr>
                                        </g:if>
                                        <g:if test="${d.showTeacher}">
                                            <tr><td class="label">Teacher Name:</td><td class="value"><input type="text" size="50" name="teacherName" /></td></tr>
                                        </g:if>
                                        <g:if test="${d.showRoomNumber}">
                                            <tr><td class="label">Room Number:</td><td class="value"><input type="text" size="10" name="roomNumber" /></td></tr>
                                        </g:if>
                                        <g:if test="${d.showQuantity}">
                                            <tr><td class="label">Quantity:</td><td class="value"><input type="text" size="5" name="quantity" /></td></tr>
                                        </g:if>
                                        <tr><td colspan="2" style="text-align: center"><input type="submit" value="Register" /> </td></tr>
                                    </table>
                                </g:form>
                            </div>
                        </g:each>
                    </div>
                    <script>
                    (function() { var tabView = new YAHOO.widget.TabView('demo'); })();
                    </script>
                </div>
            </td></tr>
        </table>

        <script>
        YAHOO.namespace("example.container");

        var dialog1;
        var dialog2;

        var showDialog = function(o) {
                    var driver = o.id;
                    var isItem = driver.indexOf('donate') == 0;
                    var quantityDisplay = isItem ? 'visible' : 'hidden'
                    var split = driver.indexOf('-');
                    var id=driver.substring(split+1);

                    document.forms['registerForm'].action = '../'+driver.substring(0, split)+'/'+id;
                    if (isItem) {
                        var nameId = 'item-'+id;
                        document.getElementById('registerInstructions').innerHTML =
                            'Registering to donate <b>'+document.getElementById(nameId).innerHTML+'</b>';
                    } else {
                        var nameId = 'position-'+id;
                        document.getElementById('registerInstructions').innerHTML =
                            'Volunteering for <b>'+document.getElementById(nameId).innerHTML+'</b>';

                    }
                    dialog1.show();
                    document.getElementById('quantityRow').style.visibility = quantityDisplay
                }

        var showOptOutDialog = function(o) { dialog2.show(); }

        function init() {

            // Define various event handlers for Dialog
            var handleSubmit = function() {
                document.getElementById('quantityRow').style.visibility = 'hidden'
                this.submit();
            };
            var handleCancel = function() {
                document.getElementById('quantityRow').style.visibility = 'hidden'
                this.cancel();
            };
            //var handleSuccess = function(o) { };
            //var handleFailure = function(o) { alert("Submission failed: " + o.status); };

            // Instantiate the Dialog
            dialog1 = new YAHOO.widget.Dialog("dialog1",
                { width : "300px",
                    fixedcenter : true,
                    visible : false,
                    constraintoviewport : true,
                    postmethod:"form",
                    buttons : [ { text:"Submit", handler:handleSubmit, isDefault:true },
                    { text:"Cancel", handler:handleCancel } ]
                 } );

            // Validate the entries in the form to require that both first and last name are entered
            dialog1.validate = function() {
                var data = this.getData();
                if (data.firstName == "" || data.lastName == "" || data.email == "" || data.phone == "") {
                    alert("Please enter complete information");
                    return false;
                } else {
                    return true;
                }
            };

            // Wire up the success and failure handlers
            //dialog1.callback = { success: handleSuccess, failure: handleFailure };

            // Render the Dialog
            dialog1.render();


            dialog2 = new YAHOO.widget.Dialog("dialog2",
            { width : "300px",
                fixedcenter : true,
                visible : false,
                constraintoviewport : true,
                postmethod:"form",
                buttons : [ { text:"Submit", handler:handleSubmit, isDefault:true },
                { text:"Cancel", handler:handleCancel } ]
             } );
        
            // Render the Dialog
            dialog2.render();
        }

        YAHOO.util.Event.onDOMReady(init);
        </script>
        <div id="dialog1">
            <div class="hd">Please enter your information</div>
            <div class="bd">
                <form id="registerForm">
                    <p id="registerInstructions"></p>
                    <input type="hidden" id="id" name="id" />
                    <table width="100%">
                        <tr><td>First Name:</td><td><input id="firstName" name="firstName" type="text" size="25" maxlength="50" autocomplete="off" /></td></tr>
                        <tr><td>Last Name:</td><td><input id="lastName" name="lastName" type="text" size="25" maxlength="50" autocomplete="off" /></td></tr>
                        <tr><td>Email:</td><td><input id="email" name="email" type="text" size="25" maxlength="32" autocomplete="off" /></td></tr>
                        <tr><td>Phone:</td><td><input id="phone" name="phone" type="text" size="12" maxlength="12" autocomplete="off" /></td></tr>
                        <tr id="quantityRow" style="visibility: hidden">
                            <td>Quantity:</td>
                            <td><input id="quantity" name="quantity" type="text" size="3" maxlength="3" autocomplete="off"/></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>

    <div id="dialog2">
        <div class="hd">Please enter your information</div>
        <div class="bd">
            <g:form controller="event" action="optOut" id="${event.id}">
                <p>Enter your name to opt out of the ${event.name}</p>
                <input type="hidden" name="id" value="${event.id}" />
                <table width="100%">
                    <tr><td>First Name:</td><td><input name="firstName" type="text" size="25" maxlength="50" /></td></tr>
                    <tr><td>Last Name:</td><td><input name="lastName" type="text" size="25" maxlength="50"  /></td></tr>
                </table>
            </g:form>
        </div>
    </div>

    </body>
</html>