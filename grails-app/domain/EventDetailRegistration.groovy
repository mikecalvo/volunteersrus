/**
 * @author mike@citronellasoftware.com
 * Created Nov 17, 2008 - 8:51:05 PM
 */
class EventDetailRegistration {

    static belongsTo = [eventDetail: EventDetail]

    String firstName
    String lastName
    String teacherName
    String roomNumber
    int quantity = 1

    static constraints = {
        firstName(nullable: true, size: 0..64)
        lastName(nullable: true, size: 0..64)
        teacherName(nullable: true, size: 0..128)
        roomNumber(nullable: true, size: 0..10)
    }
}