dataSource {
	pooled = false
	driverClassName = "org.hsqldb.jdbcDriver"
	username = "sa"
	password = ""
}

// environment specific settings
environments {
	development {
		dataSource {
            //url= "jdbc:mysql://192.168.1.201:3306/signmeup"
            //username = "signmeup_app"
            //password = "sql"
            //driverClassName = "com.mysql.jdbc.Driver"
			dbCreate = "update"
			//dbCreate = "create-drop" // one of 'create', 'create-drop','update'
			url = "jdbc:hsqldb:file:devDB"
            //url= "jdbc:mysql://localhost:3306/signmeup"
            //username = "signmeup_app"
            //password = "sql"
            //driverClassName = "com.mysql.jdbc.Driver"
        }
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:hsqldb:mem:testDb"
		}
	}
	production {
		dataSource {
            url= "jdbc:mysql://localhost:3306/signmeup"
            username = "signmeup_app"
            password = "sql"
            driverClassName = "com.mysql.jdbc.Driver"
			dbCreate = "update"
			//url = "jdbc:hsqldb:file:prodDb;shutdown=true"
		}
	}
}