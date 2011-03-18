class BootStrap {

    def init = { servletContext ->

        if (!Event.findByName("Highlands Carnival 2008")) {
            Person p = new Person(name: 'Jennifer Hovelsrud', phone: '952-925-6052', email: 'mike_calvo@yahoo.com')
            p.save()
            Event carnival = new Event(name:'Highlands Carnival 2008',
                    date: new Date(), administrator: p, startTime: 1700, endTime: 2200,  donations: true).save()
            Position foodChair = new Position(title:'Food Chair', description:'Leads all food comittees,etc.')
                    .addToReports(new Position(title:'Food Mentee'))
                    .addToReports(new Position(title:'Food General Help'));
            Position gamesChair = new Position(title:'Games Chair', description:'Orgainizes all volunteers for running games and required prizes')
                    .addToReports(new Position(title:'Games Mentee'))
                    .addToReports(new Position(title:'Games General Help'));

            carnival.addToPositions(foodChair)
            foodChair.reports.each {
                carnival.addToPositions(it)
            }

            carnival.addToPositions(gamesChair)
            gamesChair.reports.each {
                carnival.addToPositions(it)
            }

            carnival.save();

            def items = [
                    new Item(name: "Cereal").save(),
                    new Item(name: "Soda Pop").save(),
                    new Item(name: "Candy").save()
            ]

            items.each { carnival.addToItems( new EventItem(item: it)) }
            carnival.save();

            new AdminUser(email: "mike@citronellasoftware.com", password: "groovy", superUser: true, name: "Mike Calvo").save()
            new AdminUser(email: "arscott@visi.com", password: "pta", superUser: false, name: "Amy Scott").save()
            new AdminUser(email: "hovelsrud5@comcast.net", password: "einar", superUser: false, name: "Jennifer Hovelsrud").save()
        }

    }

    def destroy = {
    }
} 