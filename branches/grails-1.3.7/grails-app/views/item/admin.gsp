<html>
<head>
    <title>Event Item Admin</title>
    <meta name="layout" content="main" />
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

<%-- Items --%>
    <table style="width: 900px; border: 1px solid black" cellpadding="10" cellspacing="0">
        <tr><td colspan="5" class="tableheading">${event.name} Items</td></tr>
        <tr>
            <td colspan="5" style="border-top: 2px solid black"><input type="submit" value="Add Item" onclick="showNewItemDialog(); return false"/></td>
        </tr>
        <tr class="headerRow">
            <td>Item</td><td>Donors</td><td style="text-align: left">Description</td><td style="text-align:center">Quantity</td><td>&nbsp</td></tr>
        <g:each var="eventItem" in="${items}" status="i">
            <tr class="${i%2==0 ? 'even' : 'odd'}">
                <td style="width: 20%">${eventItem.item?.name}
                </td>
                <td style="width: 25%">
                        <g:if test="${eventItem.donations}">
                            <table>
                            <g:each var="d" in="${eventItem.donations}">
                                <tr>
                                <td>${d.donor?.name} (${d.quantity})</td>
                                <td><a href="${createLink(controller:'item', action:'removeDonation', id:d.id)}"
                                        onclick="return confirm('Are you sure you want to remove this donation?')"><img src="${createLinkTo(dir:'images',file:'delete_16x16.gif')}" title="Remove this donation" border="0"/></a></td>
                                </tr>
                            </g:each>
                            </table>
                        </g:if>
                        <g:else>&nbsp;</g:else>
                </td>
                <td style="width: 45%">${eventItem.item.description}</td>
                <td style="text-align: center; width: 10px">${eventItem.numberNeeded}</td>
                <td style="width: 10%">
                    <a href="#" onclick="<g:remoteFunction controller="item" action="getItem" id="${eventItem.id}" update="getItemResponse" onComplete="showEditPersonDialog()"/>; return false"><img src="${createLinkTo(dir:'images',file:'edit_16x16.gif')}" title="Edit item details" border="0"/></a>
                    <a href="${createLink(controller:'item', action:'delete', id:eventItem.id)}" onclick="return confirm('Are you sure you want to remove this item?')"><img src="${createLinkTo(dir:'images',file:'delete_16x16.gif')}" title="Delete item" border="0"/></a>
                </td>
            </tr>
        </g:each>

    </table>
<script type="text/javascript">
    var handleSubmit = function() { this.submit(); };
    var handleCancel = function() { this.cancel(); };
    var newDialog;
    var editDialog;

    function showNewItemDialog() { newDialog.show(); }

    // Display the edit person dialog filling in the fields with the response from the AJAX call
    var showEditPersonDialog = function() {
        var json = eval( '('+$('getItemResponse').innerHTML+')');
        $('eid').value = json.id;
        $('ename').value = json.name;
        $('edescription').value = json.description ? json.description : '';
        $('enumberNeeded').value = json.numberNeeded ? json.numberNeeded : '';
        editDialog.show();
    }

    function init() {
        // Instantiate the Dialog
        newDialog = new YAHOO.widget.Dialog("newDialog",
        { width : "300px",
            modal:true,
            fixedcenter : true,
            visible : false,
            constraintoviewport : true,
            postmethod:"form",
            buttons : [ { text:"Create", handler:handleSubmit, isDefault:true },
            { text:"Cancel", handler:handleCancel } ]
        } );

        editDialog = new YAHOO.widget.Dialog("editDialog",
        { width : "300px",
            modal:true,
            fixedcenter : true,
            visible : false,
            constraintoviewport : true,
            postmethod:"form",
            buttons : [ { text:"Update", handler:handleSubmit, isDefault:true },
            { text:"Cancel", handler:handleCancel } ]
        } );

        newDialog.render()
        editDialog.render()

    }

    YAHOO.util.Event.onDOMReady(init);

</script>
<div id="newDialog">
    <div class="hd">Add Item </div>
    <div class="bd">
        <g:form url="[controller: 'item', action: 'addItem', id: event.id]">
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td><span class="required">*</span> Denotes a required field</td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Name:</td><td class="value"><input type="text" name="name" id="name" size="25" maxlength="50"/></td>
                </tr>
                <tr>
                    <td class="label">Description:</td><td class="value"><input type="text" name="description" id="description" size="25" maxlength="255" /></td>
                </tr>
                <tr>
                    <td class="label">Quantity:</td><td class="value"><input type="text" id="numberNeeded" name="numberNeeded" size="3" maxlength="3" autocomplete="off"/></td>
                </tr>
            </table>
        </g:form>
    </div>
</div>

<div id="editDialog">
    <div class="hd">Edit Item Details</div>
    <div class="bd">
        <div id="getItemResponse" style="display: none"></div>
        <g:form url="[controller: 'item', action: 'save']">
            <input type="hidden" id="eid" name="id" />
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td><span class="required">*</span> Denotes a required field</td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Name:</td><td class="value"><input type="text" name="name" id="ename" size="25" maxlength="50"/></td>
                </tr>
                <tr>
                    <td class="label">Description:</td><td class="value"><input type="text" name="description" id="edescription" size="25" maxlength="255" /></td>
                </tr>
                <tr>
                    <td class="label">Quantity:</td><td class="value"><input type="text" id="enumberNeeded" name="numberNeeded" size="3" maxlength="3" autocomplete="off"/></td>
                </tr>
            </table>
        </g:form>
    </div>
</div>

</body>
</html>