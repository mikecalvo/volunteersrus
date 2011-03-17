class NonParticipant { 

    static belongsTo = [event: Event]

    Date registrationDate = new Date()
    String firstName
    String lastName
}