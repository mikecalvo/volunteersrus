<html>
<head>
    <title>Event PositionAdmin</title>
    <meta name="layout" content="main" />
    <script type="text/javascript">

    function showNewPositionDialog() {
        newPositionDialog.show()
        return false;
    }

    function selectDeselectAll(master) {
        var sels = YAHOO.util.Dom.getElementsByClassName('positionSelector')
        for (i=0; i < sels.length; i++)
            sels[i].checked = master.checked;
        }
    </script>

    <style type="text/css">
    .yui-panel-container select {
        _visibility: inherit;
     }

    /* to fix a bug with text fields on a modal dialog in firefox */
    .mask {
    	    overflow:visible; /* or overflow:hidden */
	}

    </style>
</head>
<body>

<table style="width: 900px; border: 1px solid black" cellpadding="10" cellspacing="0">
    <tr><td colspan="1" class="tableheading">${event.name} Positions</td></tr>
    <tr>
        <td><input type="submit" value="Add Position" onclick="showNewPositionDialog(); return false;" /></td>
    </tr>
</table>

<table style="width: 900px; border: 1px solid black" cellpadding="10" cellspacing="0">
    <tr class="headerRow">
        <td>Position</td><td style="text-align: left">Volunteer</td><td>Date</td><td>Time Frame</td><td>Location</td><td>Reports To</td><td>&nbsp</td></tr>
    <g:if test="${!positions}"><tr><td colspan="7" style="text-align: center">No positions defined for this event</td></tr></g:if>
    <g:each in="${positions}" var="p" status="i">
        <g:if test="${p}">
            <tr class="${i%2==0 ? 'even' : 'odd'}">
                <td style="width: 180px">${p.title}
                    <g:if test="${p.description}"><br>${p.description}</g:if>
                </td>
                <td style="text-align: left; width: 200px">
                    <g:if test="${p.filled}">
                        ${p.volunteer.name}
                        <a href="#" onclick="<g:remoteFunction controller="position" action="getVolunteer" id="${p.id}" update="getPersonResponse" onComplete="showEditPersonDialog()"/>; return false"><img src="${createLinkTo(dir:'images',file:'edit_16x16.gif')}" title="Edit this person's infromation" border="0"/></a>
                        <a href="${createLink(controller:'position', action:'unfill', id:p.id)}"
                                onclick="return confirm('Are you sure you want to remove this volunteer?');">
                            <img src="${createLinkTo(dir:'images',file:'delete_16x16.gif')}" title="Remove this person from this position" border="0" /></a>
                    </g:if>
                    <g:else>
                        <a href="#" onclick="showFillDialog('${p.id}'); return false;"><img src="${createLinkTo(dir:'images',file:'user1_16x16.gif')}" title="Fill this position" border="0"/></a>
                    </g:else>
                </td>
                <td style="width: 80px">${p.formattedDate}</td>
                <td style="width: 130px">${p.formattedTimeFrame}</td>
                <td style="width: 110px">${p.location}</td>
                <td style="width: 110px">
                    <g:if test="${p.manager != null}">${p.manager.title}</g:if><g:else>&nbsp;</g:else>
                </td>
                <td style="width: 60px">
                    <a href="#"onclick="<g:remoteFunction controller="position" action="getPosition" id="${p.id}" update="getPositionResponse" onComplete="showEditPositionDialog()" />; return false"><img src="${createLinkTo(dir:'images',file:'edit_16x16.gif')}" title="Edit position details" border="0"/></a>
                    <a href="${createLink(controller:'position', action:'delete', id:p.id)}" onclick="return confirm('Are you sure you want to remove this position?');"><img src="${createLinkTo(dir:'images',file:'delete_16x16.gif')}" title="Delete position" border="0"/></a>
                </td>
            </tr>
        </g:if>
        <g:else><tr><td colspan="7">Error encountered with a null row</td></tr></g:else>
    </g:each>
</table>
<script type="text/javascript">

var selectHandler = function(type,args,obj) {
var selected = args[0][0];
$('formattedDate').value = selected[1]+'/'+selected[2]+'/'+selected[0];
this.hide();
}
var calendar;


// Define various event handlers for Dialog
var handleSubmit = function() { this.submit(); };
var handleCancel = function() { this.cancel(); };
var dialog1;
var newPositionDialog;
var editPositionDialog;

var showFillDialog = function(id) {
//alert('showing '+id);
$('volunteerFirstName').value = ""
$('volunteerLastName').value = ""
$('volunteerEmail').value = ""
$('volunteerPhone').value = ""
$('editVolunteerPositionId').value = id
dialog1.show();
var unused = 'showing '+id
}

var showEditPersonDialog = function() {
var jsonResponse = eval( '('+$('getPersonResponse').innerHTML+')');
$('volunteerFirstName').value = jsonResponse.firstName
$('volunteerLastName').value = jsonResponse.lastName
$('volunteerEmail').value = jsonResponse.email
$('volunteerPhone').value = jsonResponse.phone
$('editVolunteerPositionId').value = jsonResponse.positionId
dialog1.show();
}
var showEditPositionDialog = function() {
var jsonResponse = eval( '('+$('getPositionResponse').innerHTML+')');
$('eid').value = jsonResponse.id
$('etitle').value = jsonResponse.title
$('edescription').value = jsonResponse.description ? jsonResponse.description : ''
$('elocation').value = jsonResponse.location != null ? jsonResponse.location : ''
$('eformattedDate').value = jsonResponse.formattedDate ? jsonResponse.formattedDate : ''
$('estartTime').value = jsonResponse.startTime ? jsonResponse.startTime : ''
$('eendTime').value = jsonResponse.endTime ? jsonResponse.endTime : ''
$('epositionId').value = jsonResponse.positionId
editPositionDialog.show();
}
function init() {

calendar = new YAHOO.widget.Calendar("calendar","calendarContainer", { title:"Choose the date:", close:true } );
calendar.selectEvent.subscribe(selectHandler, calendar, true)
calendar.render();

// Instantiate the Dialog
dialog1 = new YAHOO.widget.Dialog("dialog1",
{ width : "300px",
modal:true,
fixedcenter : true,
visible : false,
constraintoviewport : true,
postmethod:"form",
buttons : [ { text:"Submit", handler:handleSubmit, isDefault:true },
{ text:"Cancel", handler:handleCancel } ]
} );

newPositionDialog = new YAHOO.widget.Dialog("newPositionDialog",
{ width : "400px",
modal:true,
fixedcenter : true,
visible : false,
constraintoviewport : true,
postmethod:"form",
buttons : [ { text:"Add", handler:handleSubmit, isDefault:true },
{ text:"Cancel", handler:handleCancel } ]
} );

editPositionDialog = new YAHOO.widget.Dialog("editPositionDialog",
{ width : "400px", modal: true,
fixedcenter : true,
visible : false,
constraintoviewport : true,
postmethod:"form",
buttons : [ { text:"Save", handler:handleSubmit, isDefault:true },
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

dialog1.render();
newPositionDialog.render();
editPositionDialog.render();
}

YAHOO.util.Event.onDOMReady(init);

</script>

<div id="dialog1">
    <div class="hd">Enter the Volunteer's information</div>
    <div class="bd">
        <g:form controller="position" action="editVolunteer">
            <div id="getPersonResponse" style="display: none"></div>
            <input type="hidden" id="editVolunteerPositionId" name="id" />
            <table width="100%">
                <tr><td>First Name:</td><td><input id="volunteerFirstName" name="firstName" type="text" size="25" maxlength="50" autocomplete="off" /></td></tr>
                <tr><td>Last Name:</td><td><input id="volunteerLastName" name="lastName" type="text" size="25" maxlength="50" autocomplete="off" /></td></tr>
                <tr><td>Email:</td><td><input id="volunteerEmail" name="email" type="text" size="25" maxlength="32" autocomplete="off" /></td></tr>
                <tr><td>Phone:</td><td><input id="volunteerPhone" name="phone" type="text" size="12" maxlength="12" autocomplete="off" /></td></tr>
            </table>
        </g:form>
    </div>
</div>

<div id="newPositionDialog">
    <div class="hd">Enter Position Details</div>
    <div class="bd">
        <g:form url="[controller: 'position', action: 'newPositionForEvent', id: params['id']]">
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td><span class="required">*</span> Denotes a required field</td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Title:</td><td class="value"><input type="text" name="title" id="title" size="25" maxlength="50"/></td>
                </tr>
                <tr>
                    <td class="label">Description:</td><td class="value"><input type="text" name="description" id="description" size="25" maxlength="50" /></td>
                </tr>
                <tr>
                    <td class="label">Location:</td><td class="value"><input type="text" name="location" id="location" size="25" maxlength="50" /></td>
                </tr>
                <tr>
                    <td class="label">Date:</td>
                    <td class="value">
                        <input id="formattedDate" name="formattedDate" type="text" size="10" maxlength="10" value="${event.formattedDate}" />
                        <button id="pickDate" onclick="calendar.show(); return false">Pick</button>
                        <div id="calendarContainer" style="display: none"></div>
                    </td>
                <tr>
                    <td class="label">Time Range:</td>
                    <td class="value"><input type="text" name="startTime" id="startTime" size="4" maxlength="4" /> to
                        <input type="text" name="endTime" id="endTime" size="4" maxlength="4" /> (Military Time)
                    </td>
                </tr>
                <tr>
                    <td class="label">Reports To:</td>
                    <td class="value">
                        <g:select name="positionId" optionKey="id" optionValue="title" from="${positions}"
                                noSelection="['':'-None-']"/>
                        (Optional)
                    </td>
                </tr>
                <tr>
                    <td class="label">Quantity:</td>
                    <td class="value">
                        <input type="text" value="1" name="quantity" id="quantity" size="4" maxlength="4" />
                    </td>
                </tr>
            </table>
        </g:form>
    </div>
</div>

<div id="editPositionDialog">
    <div class="hd">Edit Position Details</div>
    <div class="bd">
        <div id="getPositionResponse" style="display: none"></div>
        <g:form url="[controller: 'position', action: 'save']">
            <input type="hidden" id="eid" name="id" />
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td><span class="required">*</span> Denotes a required field</td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Title:</td><td class="value"><input type="text" name="title" id="etitle" size="25" maxlength="50"/></td>
                </tr>
                <tr>
                    <td class="label">Description:</td><td class="value"><input type="text" name="description" id="edescription" size="25" maxlength="50" /></td>
                </tr>
                <tr>
                    <td class="label">Location:</td><td class="value"><input type="text" name="location" id="elocation" size="25" maxlength="50" /></td>
                </tr>
                <tr>
                    <td class="label">Date:</td>
                    <td class="value">
                        <input id="eformattedDate" name="formattedDate" type="text" size="10" maxlength="10" />
                    </td>
                <tr>
                    <td class="label">Time Range:</td>
                    <td class="value"><input type="text" name="startTime" id="estartTime" size="4" maxlength="4" /> to
                        <input type="text" name="endTime" id="eendTime" size="4" maxlength="4" /> (Military Time)
                    </td>
                </tr>
                <tr>
                    <td class="label">Reports To:</td>
                    <td class="value">
                        <p><g:select id="epositionId" name="positionId" optionKey="id" optionValue="title" from="${positions}"  noSelection="['':'-None-']" /></p>
                    </td>
                </tr>
            </table>
        </g:form>
    </div>
</div>
</body>
</html>