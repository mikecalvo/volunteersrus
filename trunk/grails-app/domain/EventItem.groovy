class EventItem
{
    static hasMany = [donations: ItemDonation]
    static belongsTo = [event: Event]
    static constraints = { }
    static transients = ['satisfied', 'unsatisfiedAmount']

    Item item
    int numberNeeded = 1

    String toString () {
        return "EventItem ${id}"
    }

    boolean getSatisfied() {
        getUnsatisfiedAmount() == 0
    }

    int getUnsatisfiedAmount() {
        int total = 0;
        donations.each { total += it.quantity }
        
        numberNeeded - total;
    }

}
