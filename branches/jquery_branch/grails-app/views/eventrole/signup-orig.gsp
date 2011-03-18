<html>
    <head>
        <title>Edina Highlands Elementary Volunteer Signup</title>
        <!--meta name="layout" content="main" /-->

        <link rel="stylesheet" type="text/css" href="../css/yui-2.3.1/fonts-min.css" />
        <link rel="stylesheet" type="text/css" href="../css/yui-2.3.1/assets/skins/sam/button.css" />
        <link rel="stylesheet" type="text/css" href="../css/yui-2.3.1/assets/skins/sam/container.css" />
        <script type="text/javascript" src="../js/yui-2.3.1/utilities.js"></script>
        <script type="text/javascript" src="../js/yui-2.3.1/button-beta-min.js"></script>
        <script type="text/javascript" src="../js/yui-2.3.1/container-min.js"></script>

        <!--
        <link rel="stylesheet" type="text/css" href="../css/yui-2.3.1/assets/skins/sam/button.css" />
        <link rel="stylesheet" type="text/css" href="../css/yui-2.3.1/assets/skins/sam/container.css" />
        <script type="text/javascript" src="../js/yui-2.3.1/utilities.js"></script>
        <script type="text/javascript" src="../js/yui-2.3.1/button-beta.js"></script>
        <script type="text/javascript" src="../js/yui-2.3.1/container.js"></script>
        <script type="text/javascript" src="../js/yahoo-2.3.1/yahoo-min.js"></script>
        <script type="text/javascript" src="../js/yahoo-2.3.1/dom-debug.js"></script>
        -->

    </head>
    <body>
        <script type="text/javascript">
            function init2() {

                // Define various event handlers for Dialog
                var handleSubmit = function() {
                    this.submit();
                };
                var handleCancel = function() {
                    this.cancel();
                };
                var handleSuccess = function(o) {
                    var response = o.responseText;
                    response = response.split("<!")[0];
                };
                var handleFailure = function(o) {
                    alert("Submission failed: " + o.status);
                };

                entry = new YAHOO.widget.Dialog("entry",
                                              { width : "300px",
                                                fixedcenter : true,
                                                visible : false,
                                                constraintoviewport : true,
                                                buttons : [ { text:"Submit", handler:handleSubmit, isDefault:true },
                                                            { text:"Cancel", handler:handleCancel } ]
                                              } );

                // Wire up the success and failure handlers
                entry.callback = { success: handleSuccess, failure: handleFailure };

                // Render the Dialog
                entry.render();
                YAHOO.util.Event.addListener("show", "click", entry.show, entry, true);
            }

            YAHOO.util.Event.onDOMReady(init2);

        </script>

        <script>
        YAHOO.namespace("example.container");

        function init() {

            // Define various event handlers for Dialog
            var handleSubmit = function() {
                this.submit();
            };
            var handleCancel = function() {
                this.cancel();
            };
            var handleSuccess = function(o) {
                var response = o.responseText;
                response = response.split("<!")[0];
                document.getElementById("resp").innerHTML = response;
            };
            var handleFailure = function(o) {
                alert("Submission failed: " + o.status);
            };

            // Instantiate the Dialog
            dialog1 = new YAHOO.widget.Dialog("entry",
                                                                        { width : "300px",
                                                                          fixedcenter : true,
                                                                          visible : false,
                                                                          constraintoviewport : true,
                                                                          buttons : [ { text:"Submit", handler:handleSubmit, isDefault:true },
                                                                                      { text:"Cancel", handler:handleCancel } ]
                                                                         } );

            // Validate the entries in the form to require that both first and last name are entered
            dialog1.validate = function() {
                var data = this.getData();
                if (data.firstname == "" || data.lastname == "") {
                    alert("Please enter your first and last names.");
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

            YAHOO.util.Event.addListener("show", "click", dialog1.show, dialog1, true);
            YAHOO.util.Event.addListener("hide", "click", dialog1.hide, dialog1, true);
        }

        YAHOO.util.Event.onDOMReady(init);
        </script>

        <center style="font-weight: bold">${event.name}</center>
    <div>
        <a href="#" id="show">Show dialog</a>
        <button id="hide">Hide dialog1</button>
    </div>
        <div style="width: 80%; padding-left:20px">
            Look for a position below that you'd like to sign up for and enter your name, email address, and phone number.

            <table style="width: 400px; border: 1px solid black">
                <g:each var="eventRole" in="${eventRoles}">
                    <tr>
                        <td style="vertical-align: middle;text-align: right; font-weight: bold">${eventRole.position.title}</td>
                        <td>

                            <g:if test="${eventRole.filled}">
                                ${eventRole.volunteer.name}
                            </g:if>
                            <g:else>
                            <%--a id="link-${eventRole.id}" href="#" onclick="showSignUpForm('link-${eventRole.id}'); return false">Sign up for this position</a--%>
                                <a href="#" onclick="show(); return false">Sign up for this position</a>
                            </g:else>
                        </td>
                    </tr>
                </g:each>
            </table>
        </div>

        <div id="entry" style="position: absolute; visible: hidden; display: none; width:300px">
            <form action="eventRole">
                <table width="100%">
                    <tr>
                        <td>Name: <input id="name" type="text" size="15" maxlength="50" /> </td>
                        <td>Email: <input id="email" type="text" size="15" maxlength="32" /> </td>
                        <td>Phone: <input id="phone" type="text" size="12" maxlength="12" /> </td>
                        <%-- <td><input type="submit" value="Sign Up" /><input type="submit" value="Cancel" onclick="hide(); return false" /></td> --%>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>