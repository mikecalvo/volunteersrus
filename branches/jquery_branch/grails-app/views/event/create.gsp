<html>
    <head>
        <title>Edina Highlands Elementary Sign Up Site</title>
        <meta name="layout" content="main" />
    </head>
    <body>

        <g:form contoller="event" action="${create ? 'doCreate' : 'doEdit'}" id="${event == null ? '' : event.id}">
            <table style="width: 900px; border: 1px solid black" cellspacing="0">
                <tr><td colspan="2" class="tableheading">
                    ${create ? 'Create a new' : 'Edit'} Event</td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <span class="required">*</span> Denotes a required field</td>
                </tr>
                <tr>
                    <td class='label'><span class="required">*</span> Name:</td>
                    <td class='value'>
                        <input type="text" id='name' name='name' autocomplete="off" size="45"
                                value="${event.name}"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">Description:</td>
                    <td class="value">
                        <textarea rows="5" cols="34" id="description" name="description">${event.description}</textarea>
                    </td>

                </tr>
                <tr>
                    <td class="label">Active:</td>
                    <td><g:checkBox name="active" value="${event.active}" /></td>
                </tr>
                <tr>
                    <td class="label">Support Donations:</td>
                    <td><g:checkBox name="donations" value="${event.donations}" /></td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span> Date:</td>
                    <td class="value">
                        <input id="formattedDate" name="formattedDate" type="text" size="10" maxlength="10"
                                readonly="true" value="${event.formattedDate}" />
                        <button id="pickDate" onclick="calendar.show(); return false">Pick</button>
                        <div id="calendarContainer" style="display: none"></div>
                    </td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span> Start Time:</td>
                    <td class="value"><input type="text" value="${event.startTime}" name="startTime" maxlength="4" size="4"/> (Military Time)</td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span> Start Time:</td>
                    <td class="value"><input type="text" value="${event.endTime}" name="endTime" maxlength="4" size="4"/> (Military Time)</td>
                </tr>
                <tr>
                    <td class="label">Administrator:</td><td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span> First Name:</td>
                    <td class="value"><input type="text" value="${event.administrator.firstName}" name="adminFirstName" /> </td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span> Last Name:</td>
                    <td class="value"><input type="text" value="${event.administrator.lastName}" name="adminLastName" /> </td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span> Email:</td>
                    <td class="value"><input type="text" value="${event.administrator.email}" name="adminEmail" size="45"/></td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span> Phone:</td>
                    <td class="value"><input type="text" value="${event.administrator.phone}" name="adminPhone" /></td>
                </tr>
                <tr>
                    <td class="label">Position Instructions:</td>
                    <td class="value">
                        <textarea rows="5" cols="34" id="positionInstructions" name="positionInstructions">${event.positionInstructions}</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="label">Item Instructions:</td>
                    <td class="value">
                        <textarea rows="5" cols="34" id="itemInstructions" name="itemInstructions">${event.itemInstructions}</textarea>
                    </td>
                </tr>
                <tr><td colspan="2" style="text-align: center"><input type="submit" value="Save" /></td></tr>
            </table>
        </g:form>

        <script type="text/javascript">
            var calendar;

            // Define various event handlers for Dialog
            var selectHandler ;


            function init() {
                selectHandler = function(type,args,obj) {
                    var selected = args[0][0];
                    $('formattedDate').value = selected[1]+'/'+selected[2]+'/'+selected[0];
                    this.hide();
                }

                calendar = new YAHOO.widget.Calendar("calendar","calendarContainer",
                        { title:"Choose the date:", close:true } );
                calendar.selectEvent.subscribe(selectHandler, calendar, true)
                calendar.render();



            }

            YAHOO.util.Event.onDOMReady(init);
        </script>

    </body>
</html>