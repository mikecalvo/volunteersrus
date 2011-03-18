/**
 * @author mike@citronellasoftware.com
 * Created Nov 18, 2008 - 7:12:32 PM
 */
class EventDetailController {
    def index = { }

    def save = {

        Event event = Event.get(params.id)

        // save existing
        if (params.detailId) {
            EventDetail detail = EventDetail.get(params.detailId)
            detail.properties = params
            detail.save()
            flash.message = "Detail updated"
        }

        // create new
        else {
            EventDetail detail = new EventDetail()
            detail.properties = params
            detail.displayOrder = event.details.size()+1
            event.addToDetails(detail)
            event.save()
            flash.message = "Detail added"
        }

        redirect(action: 'admin', id: event.id)
    }

    def getDetail = {
        EventDetail d = EventDetail.get(params.id)
        if (d) {
            render(builder:'json') {
                id(d.id)
                name(d.name)
                instructions(d.instructions)
                showFirstName(d.showFirstName)
                showLastName(d.showLastName)
                showQuantity(d.showQuantity)
                showRoomNumber(d.showRoomNumber)
                showTeacher(d.showTeacher)
            }
        }
    }

    def delete = {
        EventDetail a = EventDetail.get(Long.parseLong(params.id))
        Event e = a.event
        def i = a.displayOrder

        e.details.each { if (it != null && it.displayOrder >= i) { it.displayOrder--;  } }
        a.delete();
        e.removeFromDetails(a);
        e.save()

        flash.message = "Detail removed"
        redirect(action: 'admin', id: e.id)
    }

    def up = {
        EventDetail a = EventDetail.get(Long.parseLong(params.id))
        Event e = a.event
        def i = a.displayOrder
        if (i > 0) {
            a.displayOrder--
            e.details.each {
                if (it && it != a && it.displayOrder == a.displayOrder)
                    it.displayOrder++
            }
            e.save()
        }
        redirect(action: 'admin', id: e.id)
    }

    def down = {
        EventDetail a = EventDetail.get(Long.parseLong(params.id))
        Event e = a.event
        def i = a.displayOrder
        if (i < e.details.size()-1) {
            a.displayOrder++
            e.details.each { if (it && it != a && it.displayOrder == a.displayOrder) it.displayOrder-- }
            e.save()
        }
        redirect(action: 'admin', id: e.id)
    }

    def admin = {
        Event e = Event.get(Long.parseLong(params.id))

        def sorted = e.details.findAll { it != null}
        [event: e, currentCrumb:'Edit Details', sorted: sorted.sort {it.displayOrder}]
    }

    def register = {
        EventDetail d = EventDetail.get(params.id)

        if (d) {
            EventDetailRegistration r = new EventDetailRegistration();
            r.properties = params;

            d.addToRegistrations(r)

            r.save()

            flash.message = "Successfully registered for ${d.name}"
            redirect(action:'detail', controller: 'event', id: d.event.id)

        } else {
            flash.error = "Not a vaild event detail to register for"
            redirect(action:'available', controller:'event')
        }

        
    }
}