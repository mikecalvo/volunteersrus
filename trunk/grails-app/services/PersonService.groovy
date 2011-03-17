/**
 * Created by IntelliJ IDEA.
 * User: mike
 * Date: Jan 19, 2008
 * Time: 2:05:05 PM
 * To change this template use File | Settings | File Templates.
 */
class PersonService {

    static transactional = true

    /** Look for the person specified by the parameters.  If they can't be found already, create a new person. */
    def getPerson(parameters) {
        def firstName = parameters.firstName
        def lastName = parameters.lastName
        def email = parameters.email
        def phone = parameters.phone

        if (!firstName || !lastName || !email || !phone)
            return null;

        firstName = firstName.trim()
        lastName = lastName.trim()

        def person

        // Look to see if the person exists already
        def existing = Person.find("from Person where lower(firstName)=? and lower(lastName)=?",
                [firstName.toLowerCase(), lastName.toLowerCase()])
        if (existing != null) {
            person = existing
        }
        else {
            person = new Person()
        }

        // Update the properties for the person
        person.properties = parameters
        person.save();

        return person
    }

    def getPositionsVolunteeredFor(Event e, Person p) {
        return Position.findAll("from Position where event = ?and volunteer =?",[e, p])
    }

    def getItemsDonatedBy(Event e, Person p) {
        return ItemDonation.findAll("from ItemDonation where donation.event = ? and donor = ?", [e,p])
    }
}