import java.text.SimpleDateFormat

class Position {
    static belongsTo = [event:Event, manager: Position]
    static hasMany = [reports:Position]
    static mappedBy = [reports:"manager"]
    static constraints = {
        title(maxSize: 50)
        description(nullable: true)
        reports()
        manager(nullable: true)
        volunteer(nullable: true)
        date(nullable: true)
        startTime(nullable: true, min: 0, max: 2399)
        endTime(nullable: true, min: 0, max: 2399)
        location(nullable: true, maxSize: 50)
        filledDate(nullable: true)
    }

    static transients = [ "filled", "formattedTimeFrame", "formattedDate" ]
    
   // Position is a keyword in some databases
    static mapping = { table 'eventposition' }

    String title
    String description
    Person volunteer
    String location
    Date date
    Integer startTime
    Integer endTime
    Date filledDate = null

    String toString () {
        return "${title}"
    }

    boolean isFilled() {
        volunteer != null
    }

    String getFormattedTimeFrame() {
        Utils.formatTimeFrame startTime, endTime
    }

    String getFormattedDate() {
        return date != null ? new SimpleDateFormat("MM/dd/yyyy").format(date) : "";
    }

    void setFormattedDate(String formattedDate) {
        if (formattedDate)
            date = new SimpleDateFormat("MM/dd/yyy").parse(formattedDate)
    }
    
}
