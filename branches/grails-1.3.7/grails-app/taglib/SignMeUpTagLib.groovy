class SignMeUpTagLib {

    static namespace = "s"

    def isLoggedIn = { attrs, body ->
        if (session.user != null) out << body()
    }

    def isNotLoggedIn = { attrs, body ->
        if (session.user == null)
            out << body()
    }

    def isSuperUser = { attrs, body ->
        if (session.user != null && session.user.superUser)
            out << body()
    }

    def userName = { attrs, body ->
        out << (session.user != null ? session.user.name : 'Not Logged In')
    }
}