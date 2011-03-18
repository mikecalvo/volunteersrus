<html>
    <head>
        <title>Edina Highlands Elementary Sign Up Site</title>
        <meta name="layout" content="main" />
    </head>
    <body>

            <table style="width: 900px; border: 1px solid black" cellspacing="0" cellpadding="10" >
                <tr><td class="tableheading" colspan="4">Edit Registrations for ${event.name}</td></tr>
                <tr><td colspan="4"><input type="submit" value="Add Detail" onclick="showDetailDialog(); return false;" /></td></tr>
                <tr class="headerRow">
                    <td style="text-align: left">Name</td><td style="text-align: left">Instructions</td><td>&nbsp;</td></tr>

                <g:each var="detail" in="${sorted}" status="i">
                    <tr class="${i %2 == 0 ? 'even' : 'odd'}">
                        <td>${detail.name}</td>
                        <td>${detail.instructions}</td>
                        <td style="text-align: right">
                            <g:if test="${i != 0}">
                                <a href="<g:createLink controller="eventDetail" action="up" id="${detail.id}" />"><img src="${createLinkTo(dir:'images',file:'up_16x16.gif')}" title="Move up" border="0"/></a>
                            </g:if>
                            <g:if test="${i  < sorted.size()-1}">
                                <a href="<g:createLink controller="eventDetail" action="down" id="${detail.id}" />"><img src="${createLinkTo(dir:'images',file:'down_16x16.gif')}" title="Move down" border="0"/></a>
                            </g:if>
                            <a href="#" onclick="<g:remoteFunction controller="eventDetail" action="getDetail" id="${detail.id}" 
                                    update="response" onComplete="showEditDialog()"/>; return false"><img src="${createLinkTo(dir:'images',file:'edit_16x16.gif')}" title="Edit registration" border="0"/></a>
                            <a href="<g:createLink controller="eventDetail" action="delete" id="${detail.id}" />"
                                    onclick="return confirm('Are you sure you want to delete this registration (all people signed up for it will be removed)?')"><img src="${createLinkTo(dir:'images',file:'delete_16x16.gif')}" title="Delete registration" border="0"/></a>

                        </td>
                    </tr>
                </g:each>
            </table>

        <script type="text/javascript">

            // Define various event handlers for Dialog
            var handleSubmit = function() { this.submit(); };
            var handleCancel = function() { this.cancel(); };
            var dialog1;

            var showDetailDialog;
            var showEditDialog;

            function init() {
                showDetailDialog = function() {
                    $('detailId').value = '';
                    $('name').value = '';
                    $('instructions').value = '';
                    $('showFirstName').checked = false;
                    $('showLastName').checked = false;
                    $('showTeacher').checked = false;
                    $('showRoomNumber').checked = false;
                    $('showQuantity').checked = false;
                    dialog1.show();
                }

                showEditDialog = function() {
                    var json = eval( '('+$('response').innerHTML+')');
                    $('detailId').value = json.id;
                    $('name').value = json.name;
                    $('instructions').value = json.instructions ? json.instructions : '';
                    $('showFirstName').checked = json.showFirstName;
                    $('showLastName').checked = json.showLastName;
                    $('showTeacher').checked = json.showTeacher;
                    $('showRoomNumber').checked = json.showRoomNumber;
                    $('showQuantity').checked = json.showQuantity;

                   dialog1.show();
                }
                // Instantiate the Dialog
                dialog1 = new YAHOO.widget.Dialog("dialog1",
                    { width : "500px",
                        fixedcenter : true,
                        visible : false,
                        constraintoviewport : true,
                        postmethod:"form",
                        buttons : [ { text:"Submit", handler:handleSubmit, isDefault:true },
                        { text:"Cancel", handler:handleCancel } ]
                } );

                dialog1.render();
            }


            YAHOO.util.Event.onDOMReady(init);
        </script>

    <div id="dialog1">
        <div id="response" style="display: none"></div>            
        <div class="hd">Add Detail</div>
        <div class="bd">
            <g:form action="save">
                <input type="hidden" name="id" value="${event.id}" />
                <input type="hidden" id="detailId" name="detailId" value="" />
                <table width="100%">
                    <tr><td>Tab Name:</td><td><input id="name" name="name" type="text" size="25" maxlength="100"  /></td></tr>
                    <tr><td>Instructions:</td><td><textarea id="instructions" name="instructions" cols="45"></textarea></td></tr>
                    <tr>
                        <td colspan="2">
                            <input type="checkbox" id="showFirstName" name="showFirstName" />First Name&nbsp;&nbsp;
                            <input type="checkbox" id="showLastName" name="showLastName" />Last Name&nbsp;&nbsp;
                            <input type="checkbox" id="showTeacher" name="showTeacher" />Teacher&nbsp;&nbsp;
                            <input type="checkbox" id="showRoomNumber" name="showRoomNumber" />Room Number&nbsp;&nbsp;
                            <input type="checkbox" id="showQuantity" name="showQuantity" />Quantity&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
            </g:form>
        </div>
    </div>
    </body>
</html>