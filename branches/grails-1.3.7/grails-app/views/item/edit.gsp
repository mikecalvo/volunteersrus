<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Highlands Volunteer Site Admin</title>
    <meta name="layout" content="main" />
</head>

<body>
<g:form controller="item" action="save" id="${eventItem.id}">

    <table style="border: 1px solid green" width="900px" cellspacing="0" cellpadding="3">
        <tr><td colspan="2" class="tableheading">Edit Item for ${event.name}</td></tr>
        <tr>
            <td style="text-align: right">
                <span class="required">*</span> Denotes a required field</td><td>&nbsp;</td>
        </tr>
        <tr>
            <td class="label"><span class="required">*</span>Name:</td>
            <td class="value"><input type="text" name="name" id="name" size="25" maxlength="50" value="${eventItem.item.name}"/></td>
        </tr>
        <tr>
            <td class="label">Description:</td>
            <td class="value"><textarea rows="5" cols="34" id="description" name="description">${eventItem.item.description}</textarea>
            </td>
        </tr>
        <tr>
            <td class="label">Quantity:</td>
            <td class="value"><input type="text" name="numberNeeded" id="numberNeeded" size="5" maxlength="4" value="${eventItem.numberNeeded}" /></td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>
                <input type="submit" value="Save" />
            </td>
        </tr>
    </table>
</g:form>

</body>
</html>