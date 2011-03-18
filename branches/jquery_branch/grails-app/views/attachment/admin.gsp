<html>
    <head>
        <title>Edina Highlands Elementary Sign Up Site</title>
        <meta name="layout" content="main" />
    </head>
    <body>

            <table style="width: 900px; border: 1px solid black" cellspacing="0" cellpadding="10" >
                <tr><td class="tableheading" colspan="4">Edit Attachments for ${event.name}</td></tr>
                <tr><td colspan="4"><input type="submit" value="Add Attachment" onclick="showAttachmentDialog(); return false;" /></td></tr>
                <tr class="headerRow">
                    <td style="text-align: left">Name</td><td style="text-align: left">File Type</td><td>&nbsp;</td><td>&nbsp;</td></tr>

                <g:each var="attachment" in="${sorted}" status="i">
                    <tr class="${i %2 == 0 ? 'even' : 'odd'}">
                        <td>${attachment.name}</td>
                        <td>${attachment.mimeType}</td>
                        <td>
                            <a href="<g:createLink controller="attachment" action="view" id="${attachment.id}" />"
                                    onClick="window.open('','popup','height=500,width=500,scrollbars=no')" target="popup">View File</a> &nbsp;

                        </td>
                        <td style="text-align: right">
                            <g:if test="${i != 0}">
                                <a href="<g:createLink controller="attachment" action="up" id="${attachment.id}" />"><img src="${createLinkTo(dir:'images',file:'up_16x16.gif')}" title="Move up" border="0"/></a>
                            </g:if>
                            <g:if test="${i  < sorted.size()-1}">
                                <a href="<g:createLink controller="attachment" action="down" id="${attachment.id}" />"><img src="${createLinkTo(dir:'images',file:'down_16x16.gif')}" title="Move down" border="0"/></a>
                            </g:if>
                            <a href="<g:createLink controller="attachment" action="delete" id="${attachment.id}" />" onclick="return confirm('Are you sure you want to delete this attachment?')"><img src="${createLinkTo(dir:'images',file:'delete_16x16.gif')}" title="Delete attachment" border="0"/></a>

                        </td>
                    </tr>
                </g:each>
            </table>

        <script type="text/javascript">

            // Define various event handlers for Dialog
            var handleSubmit = function() { this.submit(); };
            var handleCancel = function() { this.cancel(); };
            var dialog1;

            var showAttachmentDialog;

            function init() {
                showAttachmentDialog = function() {
                    $('attachmentName').value = ""
                    $('attachmentFile').value = ""
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
        <div class="hd">Add Attachment</div>
        <div class="bd">
            <g:form action="attach" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${event.id}" />
                <table width="100%">
                    <tr><td>Document Name:</td><td><input id="attachmentName" name="attachmentName" type="text" size="25" maxlength="100"  /></td></tr>
                    <tr><td>Attachment File:</td><td><input id="attachmentFile" name="attachmentFile" type="file" size="40"/></td></tr>
                </table>
            </g:form>
        </div>
    </div>
    </body>
</html>