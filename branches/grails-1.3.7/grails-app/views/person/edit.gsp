

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit Person</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Person List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Person</g:link></span>
        </div>
        <div class="body">
            <h1>Edit Person</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${person}">
            <div class="errors">
                <g:renderErrors bean="${person}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${person?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">Email:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:person,field:'email','errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean:person,field:'email')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="phone">Phone:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:person,field:'phone','errors')}">
                                    <input type="text" maxlength="12" id="phone" name="phone" value="${fieldValue(bean:person,field:'phone')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName">First Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:person,field:'firstName','errors')}">
                                    <input type="text" id="firstName" name="firstName" value="${fieldValue(bean:person,field:'firstName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastName">Last Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:person,field:'lastName','errors')}">
                                    <input type="text" id="lastName" name="lastName" value="${fieldValue(bean:person,field:'lastName')}"/>
                                </td>
                            </tr>                         
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
