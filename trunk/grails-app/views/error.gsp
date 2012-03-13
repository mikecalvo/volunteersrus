<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Highlands Volunteer Site AdminLogin</title>
    <style type="text/css">
    .message {
    border: 1px solid black;
    padding: 5px;
    background-color:#E9E9E9;
    text-align: left
    }
    .stack {
    border: 1px solid black;
    padding: 5px;
    overflow:auto;
    height: 300px;
    text-align: left;
    }
    .snippet {
    padding: 5px;
    background-color:white;
    border:1px solid black;
    margin:3px;
    font-family:courier;
    text-align: left;
    }
    </style>
</head>

<body>
<!--div class="sidebar"-->
<center>
    <table width="900px" style="padding-bottom: 5px">
        <tr>
            <td width="100px">
                <img src="${createLinkTo(dir:'images',file:'logo.gif')}" alt="Edina Highlands Elementary" />
            </td>
            <td style="text-align: right">
                <s:isLoggedIn>
                    Logged in as <s:userName />
                    <br/><g:link controller="admin" action="logout">Logout</g:link>
                </s:isLoggedIn>
                <s:isNotLoggedIn><a href="${createLink(controller:'admin')}">Admin Login</a></s:isNotLoggedIn>
            </td>
        </tr>
    </table>
    <div style="width:900px">
        <p style="color: red; font-weight: bold">We appologize, but an unexpcted error has occurred.</p>
        <p style="text-align: left">If you have time, please send an email to
            <a href="mailto:edinahighlandsvolunteers@gmail.com?subject=attn Site Manager: Highlands Volunteer Site Error">Website Manager</a> and please provide any detailed information that you
        can about how you received this error.  It will help us prevent it in the future.</p>
        <p style="text-align: left">Please copy the the information below into the body of your email.</p>
        <p>Thank you.</p>

        <div class="message">
            <strong>Request:</strong> ${request.requestURL} <br />
            <strong>Date and time:</strong><g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${new Date()}" /> <br />
            <strong>Message:</strong> ${exception.message?.encodeAsHTML()} <br />
            <strong>Caused by:</strong> ${exception.cause?.message?.encodeAsHTML()} <br />
            <strong>Class:</strong> ${exception.className} <br />
            <strong>At Line:</strong> [${exception.lineNumber}] <br />
            <%--
            <strong>Code Snippet:</strong><br />
            <div class="snippet">
                <g:each var="cs" in="${exception.codeSnippet}">
                    ${cs?.encodeAsHTML()}<br />
                </g:each>
            </div>
            --%>
        </div>
        <!--
           ${exception.stackTraceText?.encodeAsHTML()}
        -->
    </div>
</center>



</body>
</html>