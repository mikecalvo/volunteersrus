class AdminUserController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    def static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        if(!params.max) params.max = 10
        [ adminUserList: AdminUser.list( params ) ]
    }

    def show = {
        def adminUser = AdminUser.get( params.id )

        if(!adminUser) {
            flash.message = "AdminUser not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ adminUser : adminUser ] }
    }

    def delete = {
        def adminUser = AdminUser.get( params.id )
        if(adminUser) {
            adminUser.delete()
            flash.message = "AdminUser ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "AdminUser not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def adminUser = AdminUser.get( params.id )

        if(!adminUser) {
            flash.message = "AdminUser not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ adminUser : adminUser ]
        }
    }

    def update = {
        def adminUser = AdminUser.get( params.id )
        if(adminUser) {
            adminUser.properties = params
            if(!adminUser.hasErrors() && adminUser.save()) {
                flash.message = "AdminUser ${params.id} updated"
                redirect(action:show,id:adminUser.id)
            }
            else {
                render(view:'edit',model:[adminUser:adminUser])
            }
        }
        else {
            flash.message = "AdminUser not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def adminUser = new AdminUser()
        adminUser.properties = params
        return ['adminUser':adminUser]
    }

    def save = {
        def adminUser = new AdminUser(params)
        if(!adminUser.hasErrors() && adminUser.save()) {
            flash.message = "AdminUser ${adminUser.id} created"
            redirect(action:show,id:adminUser.id)
        }
        else {
            render(view:'create',model:[adminUser:adminUser])
        }
    }
}
