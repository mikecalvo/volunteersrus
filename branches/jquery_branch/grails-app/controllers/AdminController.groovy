class AdminController {

    def scaffold = AdminUser

    def index = {
        log.info("Someone is going to the admin user index page")
        render(view: "login")
    }

    def login = {
        AdminUser user = AdminUser.findByEmailAndPassword(params.email, params.password)
        if (user != null) {
            session.user = user;
            redirect(controller: "event", action: "available")
        } else {
            flash.message = 'Login failed - try again'
            render(view: "login")
        }
    }

    def logout = {
        session.user = null;
        flash.message = "Successfully logged out"
        redirect(controller: "event", action: "available")
    }
}