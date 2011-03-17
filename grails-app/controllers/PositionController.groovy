class PositionController {

    def personService
    def emailService

    def admin = {
        Event e = Event.get(Long.parseLong(params.id))
        List positions = new ArrayList(e.positions)
        positions = positions.findAll { it != null }
        positions.sort { it.title }

        List items = new ArrayList(e.items)
        items = items.findAll { it != null && it.item != null}
        items.sort { it.item.name }

        return [event: e, positions: positions, currentCrumb: "Edit Positions"] 
    }

    /** Add a new position within the context of an event */
    def newPositionForEvent = {
        int quantity = 0
        Event e = Event.get(Long.parseLong(params.id))
        if (!e) {
            flash.error = "Error - no event specified"
            redirect(controller: 'event', action: 'available')
        } else if (!params.title) {
            flash.error = "Position not added -  title required"
            redirect(controller: 'position', action: 'admin', id: e.id)
        } else {
            quantity = Integer.parseInt(params.quantity);
            Person person = personService.getPerson(params)

            for (int i = 0; i < quantity; i++) {
                Position p = new Position(params)
                if (i == 0 && person) {
                    p.volunteer = person
                    p.filledDate = new Date()
                }
                e.addToPositions(p)
                e.save()
                p.save()
                log.info("Created new position for ${e.name}: ${p.id} ${p.title}")
                if (p.volunteer && params.sendEmail) {
                    emailService.sendVolunteerConfirmation(p, Utils.getBaseAppUrl(request.getRequestURL().toString(), "event"))
                }

                addToManager params.positionId, p
            }

            flash.message = "${quantity} Position${quantity != 1 ? 's' :''} ${params.title} added"
            redirect(controller: 'position', action: 'admin', id: params.id)
        } 
    }

    def edit = {
        log.info("Loading position ${params.id}")
        Position p = Position.get(Long.parseLong(params.id))
        [position: p, event: p.event, currentCrumb: "Edit Position" ]
    }

    def save = {
        Position p = Position.get(Long.parseLong(params.id))
        if (p != null) {
            p.properties = params
            p.save()
            addToManager params.positionId, p

            flash.message = "Saved Positon"
            redirect(controller: 'position', action: 'admin', id: p.event.id)
        } else {
            flash.error = "The requested position could not be found"
            redirect(controller: 'event', action: 'available')
        }
    }

    private void addToManager(String positionId, Position p) {
        if (positionId) {
            Position manager = Position.get(Long.parseLong(positionId))
            manager.addToReports(p)
            manager.save()
        } else if (p.manager) {
            Position manager = p.manager
            manager.removeFromReports(p)
            manager.save()
        }
    }

    def delete = {
        if (params.id) {
            Position p = Position.get(params.id)
            if (p) {
                Event e = p.event
                if (p.reports) {
                    flash.error = "This position has reports and cannot be deleted until the reports are deleted"
                } else {
                    def removed = p.title
                    def manager = p.manager
                    e.removeFromPositions(p)
                    if (manager) {
                        manager.removeFromReports(p)
                        manager.save()
                    }
                    p.delete()
                    e.save()
                    flash.message = "Removed position ${removed}"
                }
                redirect(controller: 'position', action: 'admin', id: e.id)
            } else {
                flash.error = "Could not find position to delete"
                redirect(controller: 'event', action: 'available')
            }
        } else {
            flash.message = "Error - no position specified"
            redirect(controller: 'event', action: 'available')
        }

    }

    /** Remove the currently assigned volunteer from the position */
    def unfill = {
        if (params.id) {
            Position p = Position.get(params.id)
            if (p) {
                p.volunteer = null
                p.filledDate = null
                p.save()

                flash.message = "Position has been unassigned"
                redirect(controller: 'position', action: 'admin', id: p.event.id)
                return
            }
        }

        flash.error = "No position id specified to unfill"
        redirect(controller: 'event', action: 'available')
    }

    def confirmation = {
        [position: Position.get(params.id)]
    }

    def getVolunteer = {
        Position p = Position.get(params.id)
        if (p && p.isFilled()) {
            render(builder:'json') {
                firstName(p.volunteer.firstName)
                lastName(p.volunteer.lastName)
                email(p.volunteer.email)
                phone(p.volunteer.phone)
                positionId(p.id)
            }
        }
    }

    def editVolunteer = {
        Position p = Position.get(Long.parseLong(params.id))
        if (p) {
            Person person = personService.getPerson(params)
            if (person) {
                p.volunteer = person
                p.save()

                flash.message = "Volunteer updated"
                redirect(controller: 'position', action: 'admin', id: p.event.id)
            } else {
                flash.error = "Volunteer information incomplete"
                redirect(controller: 'position', action: 'admin', id: p.event.id)
            }
        } else {
            flash.error = "No position selected"
            redirect(controller: 'event', action: 'available')
        }
    }

    def getPosition =  {
        Position p = Position.get(params.id)
        if (p) {
            render(builder:'json') {
                id(p.id)
                title(p.title)
                description(p.description)
                positionId(p.manager?.id)
                location(p.location)
                formattedDate(p.formattedDate)
                startTime(p.startTime)
                endTime(p.endTime)
            }
        }
    }
}