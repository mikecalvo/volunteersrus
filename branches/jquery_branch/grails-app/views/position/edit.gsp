<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Highlands Volunteer Site Admin</title>
    <meta name="layout" content="main" />
</head>

<body>
<g:form controller="position" action="save" id="${position.id}">

    <table style="border: 1px solid green" width="900px" cellspacing="0" cellpadding="3">
        <tr><td colspan="2" class="tableheading">Edit Position for ${position.event.name}</td></tr>
        <tr>
            <td style="text-align: right">
                <span class="required">*</span> Denotes a required field</td><td>&nbsp;</td>
        </tr>
        <tr>
            <td class="label"><span class="required">*</span>Title:</td>
            <td class="value"><input type="text" name="title" id="title" size="25" maxlength="50" value="${position.title}"/></td>
        </tr>
        <tr>
            <td class="label">Description:</td>
            <td class="value"><input type="text" name="description" id="description" size="25" maxlength="50" value="${position.description}" /></td>
        </tr>
        <tr>
            <td class="label">Location:</td>
            <td class="value"><input type="text" name="location" id="location" size="25" maxlength="50" value="${position.location}" /></td>
        </tr>
        <tr>
            <td class="label">Date:</td>
            <td class="value">
                <input id="formattedDate" name="formattedDate" type="text" size="10" maxlength="10" value="${position.formattedDate}" />
                <button id="pickDate" onclick="calendar.show(); return false">Pick</button>
                <div id="calendarContainer" style="display: none"></div>
            </td>
        <tr>
            <td class="label">Time Range:</td>
            <td class="value"><input type="text" name="startTime" id="startTime" size="4" maxlength="4" value="${position.startTime}"/> to
                <input type="text" name="endTime" id="endTime" size="4" maxlength="4" value="${position.endTime}" />
                (Use Military Time or leave blank)
            </td>
        </tr>
        <tr>
            <td class="label">Reports To:</td>
            <td class="value">
                <g:select name="positionId" optionKey="id" optionValue="title" from="${Position.list()}"
                        value="${position.manager != null ? position.manager.id: ''}"
                        noSelection="['':'-None-']"/>
                (Optional)
            </td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>
                <input type="submit" value="Save" />
            </td>
        </tr>
    </table>
</g:form>

<script type="text/javascript">
var selectHandler = function(type,args,obj) {
var selected = args[0][0];
document.getElementById('formattedDate').value = selected[1]+'/'+selected[2]+'/'+selected[0];
this.hide();
}
var calendar = new YAHOO.widget.Calendar("calendar","calendarContainer",
{ title:"Choose the date:", close:true } );
calendar.selectEvent.subscribe(selectHandler, calendar, true)
calendar.render();
</script>
</body>
</html>