/**
 * Describe me please.
 *
 * @author Mike Calvo (mike@citronellasoftware.com)
 * Created: Dec 16, 2007 8:16:02 PM
 */
class SecurityFilters {



    def filters = {

        all(controller: '*', action: '*') {
            List unsecuredActions = ['login', 'logout', 'index', 'available', 'donate', 'volunteer', 'detail',
                    'confirmation', 'optOut', 'view', 'register']

            before = {
                if (!unsecuredActions.contains(actionName)) {
                    if (session.user == null) {
                        redirect(controller: 'admin', action: 'index')
                        return false
                    } else if (controllerName.equals("adminUser") && !session.user.superUser){
                        redirect(controller: 'admin', action: 'index')
                        return false
                    }
                }

                return true

            }
        }

    }
}