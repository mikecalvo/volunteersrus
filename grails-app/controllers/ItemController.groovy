import org.apache.commons.lang.StringUtils

class ItemController {
    def scaffold = EventItem

     def edit = {
        log.info("Loading eventItem ${params.id}")
        EventItem e = EventItem.get(Long.parseLong(params.id))
        [eventItem: e, event: e.event, currentCrumb: "Edit Item" ]
    }

    def save = {
        EventItem eventItem = EventItem.get(Long.parseLong(params.id))
        if (eventItem != null) {
            eventItem.item.name = params.name
            eventItem.item.description = params.description
            eventItem.numberNeeded = Integer.parseInt(params.numberNeeded)
            eventItem.save()
            flash.message = "Saved item"
            redirect(controller: 'item', action: 'admin', id: eventItem.event.id)
        } else {
            flash.error = "The requested item could not be found"
            redirect(controller: 'event', action: 'available')
        }
    }

    def admin = {
        Event e = Event.get(Long.parseLong(params.id))
        if (e) {
            List items = new ArrayList(e.items)
            items = items.findAll { it != null && it.item != null}
            items.sort { it.item.name }

            return [event: e, items: items, currentCrumb: "Edit Items"]
        }

        redirect(controller: 'event', action: 'available')        
    }

    def addItem = {
        Event event = Event.get(Long.valueOf(params.id))
        if (event != null) {
            Item i = new Item(params);
            int quantity = 1
            if (params.numberNeeded && StringUtils.isNumeric(params.numberNeeded))
                quantity = Integer.parseInt(params.numberNeeded)

            i.save()
            event.addToItems(new EventItem(item: i, numberNeeded: quantity))
            event.save()
        }

        flash.message = "${params.name} added"
        redirect(controller: 'item', action: 'admin', id:event.id)
    }

    /* Remove the specified event item by id - redirect back to the admin page when done */
    def delete = {
        EventItem i = EventItem.get(Long.parseLong(params.id))
        Event e = i.event
        if (i && e) {
            if (i.donations) {
                flash.error = 'You must remove all donations before removing an item'
            } else {
                def removed = i.item.name
                e.removeFromItems(i)
                i.delete()
                i.save()

                flash.message = "${removed} removed"
            }
            redirect(controller: 'item', action: 'admin', id: e.id)
        } else {
            redirect(controller: 'event', action: 'available')
        }

    }

    def getItem =  {
        EventItem i = EventItem.get(params.id)
        if (i) {
            render(builder:'json') {
                id = i.id
                name = i.item.name
                description = i.item.description
                numberNeeded = i.numberNeeded
            }
        }
    }

    def removeDonation = {
        ItemDonation d = ItemDonation.get(params.id)
        if (d) {
            EventItem i = d.donation
            i.removeFromDonations(d)
            i.save()
            d.delete()
            flash.message = 'Donation removed'

            redirect(action: 'admin', id: i.event.id)
        } else {
            redirect(controller: 'event', action: 'available')
        }
    }
}