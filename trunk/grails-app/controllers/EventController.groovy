import org.apache.commons.lang.StringUtils

class EventController {

    def emailService
    def personService

    // Show a list of available events
    def available = {

        def allEvents = session.user != null ? Event.list() : Event.findAllByActive(true);

        [ events: allEvents ]
    }

    // Redirect the default view to the available action
    def index = { redirect(action: "available") }



    def create = {
        [event: new Event(administrator: new Person()), create: true, currentCrumb: "Create New Event"];
    }

    def delete = {
      def e = Event.get(params.id)
      if (e) {
        e.delete();
      }

      redirect(action: 'available')
    }

    def edit = {
        def e = Event.get(Long.valueOf(params.id))
        if (e) {
            render(view: 'create', model: [event: e, create: false, currentCrumb: "Edit Details"])
        }        
    }
    
    def detail = {
        Event e = Event.get(Long.valueOf(params.id))
        List positions = new ArrayList(e.positions)
        positions = positions.findAll { it != null }
        positions.sort { it.title }
        positions = positions.findAll { !it.filled }

        List items = new ArrayList(e.items)
        items = items.findAll { it != null && !it.satisfied }
        items.sort { it.item.name }

        List attachments = new ArrayList(e.attachments)
        attachments = attachments.findAll { it != null}
        attachments.sort {it.displayOrder }


        def details = new ArrayList(e.details);
        details.sort { it.displayOrder }
        return [event: e,
                attachments: attachments,
                positions: positions,
                details: details,
                items: items, detail: true]
    }

    def report = {
        def id = Long.parseLong(params.id)
        Event e = Event.get(id)
        String order = " order by title asc" // default ordering
        if (params.positionOrder) order = params.positionOrder
        String where = ""
        if (params.positionWhere) order = params.positionWhere
        def query = "from Position where event.id=? "+where+" "+order
        log.info("Finding Positions: ${query}")
        List p = Position.findAll(query, [id])

        order = ""
        if (params.itemsOrder) order = params.itemsOrder
        where = ""
        if (params.itemsWhere) where = params.itemsWhere
        query = "from EventItem where event.id=? "+where+" "+order
        log.info("Finding Items: ${query}")
        List i = EventItem.findAll(query, [id])

        List n = NonParticipant.findAll("from NonParticipant where event.id=? order by lastName asc", [id])
        return [event: e, positions: p, items: i, positionWhere: params.positionWhere, nonParticipants: n, currentCrumb: "Report"]
    }

    static def positionWheres = [ new WhereOption(key:"", label: "All"),
            new WhereOption(key:" and volunteer is not null ", label:"Filled"),
            new WhereOption(key:" and volunteer is null", label: "Open") ]

    def compose = { [event: Event.get(Long.valueOf(params.id)), currentCrumb: "Send Email"] }

    def sendEmail = {
        flash.message = "Your email has been sent"
        Event e = Event.get(Long.valueOf(params.id))
        def urlBase = Utils.getBaseAppUrl(request.getRequestURL().toString(), "event")
        if (!e) {

        } else if (params.recipients == "1")
            emailService.sendEmailWithParticipation(e.getVolunteers(), e, params.fromEmail, params.fromName,
                    params.subject, params.body, urlBase)
        else if (params.recipients == "2")
            emailService.sendEmailWithParticipation(e.getDonors(), e, params.fromEmail, params.fromName,
                    params.subject, params.body, urlBase)
        else if (params.recipients == "3")
            emailService.sendEmailWithParticipation(e.getAllSignedUp(), e, params.fromEmail, params.fromName,
                    params.subject, params.body, urlBase)
        else {
            flash.message = null
            flash.error = "Invalid recipient selected"
        }
        redirect(controller: 'event', action: 'detail', id: params.id)
    }

    def doCreate = {
        Event e = new Event(params)
        e.administrator = personService.getPerson([firstName: params.adminFirstName, lastName: params.adminLastName,
                phone: params.adminPhone, email: params.adminEmail])


        if (!e.validate()) {
            flash.error = "Event not saved - ${e.errors}"
        } else if (e.save()) {
            flash.message = "${e.name} created"
            redirect(action: 'available')
            return null;
        } else {
            flash.error = "Saved failed due to errors (${e.errors})"
        }


        render(view: 'create', model: [event: e, create: true])
    }

    def doEdit = {
        Event e = Event.get(Long.valueOf(params.id))
        if (e != null) {

            e.properties = params

            // Active and donationss are both checkboxes - they get handled seperately
            e.active = params.active != null
            e.donations = params.donations != null

            e.administrator = personService.getPerson([firstName: params.adminFirstName, lastName: params.adminLastName,
                    phone: params.adminPhone, email: params.adminEmail])
            if (e.itemInstructions && e.itemInstructions.length() > 1024){
                def length = e.itemInstructions.length()
                flash.error = "Item Instructions field is too long.  It can only be a maxium of 512 characters.  You entered ${length}"
                render(view: 'create', model: [event: e, create: false])
            }
            if (e.positionInstructions && e.positionInstructions.length() > 1024) {
                def length = e.positionInstructions.length();
                flash.error = "Position Instructions field is too log.  It can only be a maxium of 512 characters.  You entered ${length}"
                render(view: 'create', model: [event: e, create: false])
                return
            }
            if (!e.validate()) {
                flash.error = "Event not saved - ${e.errors}"
                render(view: 'create', model: [event: e, create: false])
            } else {
                e.save();
                flash.message = "${e.name} updated"
                redirect(action: 'detail', id: e.id)
            } 
        }
    }

    boolean validatePerson(Person person, Event event) {
        boolean valid = person.validate()
        if (!valid) {
            flash.error = "Invalid registration:"
            person.errors.allErrors.each {
                flash.error += "<br />${it.rejectedValue} is invalid ${it.field}"
            }
            redirect(action: 'detail', id: event.id)
        }

        return valid
    }

    def volunteer = {
        Position p = Position.get(Long.valueOf(params.id))
        Person volunteer = personService.getPerson(params)
        if (!validatePerson(volunteer, p.event)) {
            return
        } else {
            p.volunteer = volunteer
        }

        if (!p.validate()) {
            log.error("Errors occured attempting to save a volunteer registration")
            p.errors().each { log.error(it) }
            flash.error = "An error occurred during your registration.  Please try again later.";
            redirect(action: 'detail', id: p.event.id)
        } else {
            p.filledDate = new Date()
            p.save()
            try {
                emailService.sendVolunteerConfirmation(p, Utils.getBaseAppUrl(request.getRequestURL().toString(), "event"))
            } catch (Exception x) {
                flash.error = "An error occurred sending an email to your address ${volunteer.email}"
            }
            redirect(controller: "position", action: "confirmation", id: p.id)
        }
    }


    def donate = {
        EventItem eventItem = EventItem.get(Long.valueOf(params.id))
        Person donor = personService.getPerson(params);
        if (!validatePerson(donor, eventItem.event)) {
            return
        }
        
        int quantity = 1
        if (StringUtils.isNotBlank(params.quantity) && StringUtils.isNumeric(params.quantity))
            quantity = Integer.parseInt(params.quantity)

        int unsatisfied = eventItem.getUnsatisfiedAmount()
        if (quantity > unsatisfied)
            quantity = unsatisfied;

        ItemDonation d = new ItemDonation(donor: donor, quantity: quantity)
        eventItem.addToDonations(d)
        if (!eventItem.validate()) {
            log.error("Errors occured attempting to save a volunteer registration")
            eventItem.errors().each { log.error(it) }
            flash.error = "An error occurred during your registration.  Please try again later.";
            redirect(action: 'detail', id: eventItem.event.id, params: [itemsTab:'selected'])
        } else {
            eventItem.save();
            d.save();
            try {
            emailService.sendDonationConfirmation(d, Utils.getBaseAppUrl(request.getRequestURL().toString(), "event"))
            } catch (Exception x) { log.error("Unable to send donation confirmation email", x) }
            redirect(controller: "donation", action: "confirmation", id: d.id)
        }

    }

    def optOut = {
        Event e = Event.get(Long.valueOf(params.id))
        NonParticipant p = new NonParticipant(params)
        e.addToNonParticipants(p)
        if (p.validate()) {
            e.save()
            flash.message = "Thank you for registering.  You will not be contacted about volunteering for this event."
        } else {
            flash.error = "You did not specify valid contact information.  Your registration failed."
        }

        redirect(action: 'detail', id: e.id)
    }
}

class WhereOption {
    String key
    String label
}