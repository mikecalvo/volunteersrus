

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>AdminUser List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New AdminUser</g:link></span>
        </div>
        <div class="body">
            <h1>AdminUser List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="name" title="Name" />
                        
                   	        <g:sortableColumn property="email" title="Email" />
                        
                   	        <g:sortableColumn property="password" title="Password" />
                        
                   	        <g:sortableColumn property="superUser" title="Super User" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${adminUserList}" status="i" var="adminUser">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${adminUser.id}">${fieldValue(bean:adminUser, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:adminUser, field:'name')}</td>
                        
                            <td>${fieldValue(bean:adminUser, field:'email')}</td>
                        
                            <td>${fieldValue(bean:adminUser, field:'password')}</td>
                        
                            <td>${fieldValue(bean:adminUser, field:'superUser')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${AdminUser.count()}" />
            </div>
        </div>
    </body>
</html>
