<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta name="layout" content="main" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>Edina Highlands Elementary Volunteer Signup</title>
</head>

<body>

<script>
YAHOO.namespace("example.container");

function init() {

	// Define various event handlers for Dialog
	var handleSubmit = function() {
        // document.forms['registerForm'].submit();
        this.submit();
	};
	var handleCancel = function() {
		this.cancel();
	};
	var handleSuccess = function(o) {
	};
	var handleFailure = function(o) {
		alert("Submission failed: " + o.status);
	};

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
		if (data.name == "" || data.email == "" || data.phone == "") {
			alert("Please enter complete information");
			return false;
		} else {
			return true;
		}
	};

	// Wire up the success and failure handlers
	dialog1.callback = { success: handleSuccess,
												 failure: handleFailure };

	// Render the Dialog
	dialog1.render();

    var showDialog = function(o) {
        document.getElementById('eventRoleId').value = o.target.id;
        dialog1.show();
    }

    var links = document.getElementsByTagName('a');
    for (i = 0; i < links.length; i++) {
        if (links[i].className == "signupLink") {
            YAHOO.util.Event.addListener(links[i].id, "click", showDialog, dialog1, true);
        }
    }

}

YAHOO.util.Event.onDOMReady(init);
</script>

    <div id="dialog1">
        <div class="hd">Please enter your information</div>
        <div class="bd">
            <form id="registerForm" action="register">
                <input type="hidden" id="eventRoleId" name="eventRoleId" />
                    <table width="100%">
                        <tr><td>Name:</td><td><input id="name" name="name" type="text" size="25" maxlength="50" /></td></tr>
                        <tr><td>Email:</td><td><input id="email" name="email" type="text" size="25" maxlength="32" /></td></tr>
                        <tr><td>Phone:</td><td><input id="phone" name="phone" type="text" size="12" maxlength="12" /></td></tr>
                    </table>
            </form>
        </div>
    </div>

    <table style="width: 400px; border: 1px solid black" cellpadding="10" cellspacing="0">
        <tr>
            <td colspan="2" style="color: #ffffff; background-color: #0012dd; font-size: 14pt; font-weight: bold; text-align: center">${event.name}</td>
        </tr>
        <g:each var="eventRole" in="${eventRoles}">
            <tr>
                <td style="vertical-align: middle;text-align: right; font-weight: bold">${eventRole.position.title}</td>
                <td>

                    <g:if test="${eventRole.filled}">
                        ${eventRole.volunteer.name}
                    </g:if>
                    <g:else>
                    <%--a id="link-${eventRole.id}" href="#" onclick="showSignUpForm('link-${eventRole.id}'); return false">Sign up for this position</a--%>
                        <a href="#" id="${eventRole.id}" class="signupLink" >Sign up for this position</a>
                    </g:else>
                </td>
            </tr>
        </g:each>
    </table>


</body>
</html>
