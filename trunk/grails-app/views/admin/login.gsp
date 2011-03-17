<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Highlands Volunteer Site AdminLogin</title>
        <meta name="layout" content="main" />
    </head>

    <body>
        <g:form controller="admin" action="login">
            <table cellpadding="3" cellspacing="0" style="border: 1px solid green" width="500px">
                <tr><td colspan="2" class="tableheading">Login</td></tr>
                <tr>
                    <td class="label">Email:</td>
                    <td class="value"><input name="email" type="text" size="30" maxlength="30"/></td>
                </tr>
                <tr>
                    <td class="label">Password:</td>
                    <td class="value"><input name="password" type="password" size="10" maxlength="8" /></td>
                </tr>
                <tr>
                    <td>&nbsp</td>
                    <td><input type="submit" value="Sign in" /></td>
                </tr>
            </table>
        </g:form>
    </body>
</html>