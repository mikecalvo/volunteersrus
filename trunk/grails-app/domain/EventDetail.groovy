/**
 * @author mike@citronellasoftware.com
 * Created Nov 17, 2008 - 8:47:19 PM
 */
class EventDetail {

    static belongsTo = [event: Event]
    static hasMany = [registrations: EventDetailRegistration]

    String name
    String instructions
    boolean showFirstName
    boolean showLastName
    boolean showTeacher
    boolean showRoomNumber
    boolean showQuantity
    int displayOrder = 0

    static constraints = {
        name()
        instructions(nullable: true, size: 0..1024)
    }

    static transients = [ 'total' ]

    public int getTotal() {
        int sum = 0
        registrations.each { sum += it.quantity }
        return sum
    }
}