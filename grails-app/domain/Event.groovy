import java.text.SimpleDateFormat

class Event
{
    static hasMany = [positions:Position, items:EventItem, nonParticipants:NonParticipant, attachments:Attachment,
            details: EventDetail]

    static constraints = {
        name()
        description(nullable: true)
        date()
        startTime(min: 0, max: 2399)
        endTime(min: 0, max: 2399)
        positionInstructions(nullable: true, size: 0..1024)
        itemInstructions(nullable: true, size: 0..1024)
    }

    static transients = [ 'formattedDate', 'formattedTimeFrame' ]

    Date date
    String name
    String description
    int startTime
    int endTime
    boolean active = true
    String positionInstructions
    String itemInstructions
    boolean donations = true

    Set positions
    Set items
    Set attachments
    Person administrator

    String toString () {
        return name
    }

    String getFormattedDate() {
        return date != null ? new SimpleDateFormat("MM/dd/yyyy").format(date) : "";
    }

    public void setFormattedDate(String formattedDate) {
        if (formattedDate)
            date = new SimpleDateFormat("MM/dd/yyy").parse(formattedDate)
    }

    String getFormattedTimeFrame() {
        Utils.formatTimeFrame startTime, endTime
    }

    def getVolunteers() {
        def volunteers = []
        positions.each {
            if (it != null && it.filled)
                volunteers.add(it.volunteer)
        }
        new HashSet(volunteers)
    }

    def getDonors() {
        def donors = []
        items.each {
            if (it != null)
                it.donations.each { d->
                    donors.add(d.donor)
             }
        }

        new HashSet(donors)
    }

    def getAllSignedUp() {
        def all = getVolunteers()
        all.addAll(getDonors())
        all
    }
}
