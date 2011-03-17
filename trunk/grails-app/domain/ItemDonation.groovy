class ItemDonation
{
    // static hasMany = []
    static belongsTo = [donation: EventItem]
    // static constraints = {}

    Person donor
    int quantity
    Date donatedDate  = new Date()

    String toString () {
        return "ItemDonation ${id}"
    }
}
