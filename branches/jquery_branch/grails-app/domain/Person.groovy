class Person
{
    static transients = [ "name" ]
    static constraints = {
        email(nullable: false, email: true)
        phone(nullable: false, size: 10..12)
    }

    String firstName = ""
    String lastName = ""
    String email
    String phone

  String toString () {
    return "Person ${id}"
  }

  String getName() {
      firstName+" "+lastName
  }

  /*

  void setName(String name) {
      String[] tokens = name.split(" ")
      if (tokens.length > 0) {
          firstName = fixUpCaps(tokens[0].trim())
      }
      if (tokens.length > 1) {
          lastName = fixUpCaps(tokens[1].trim())
      }
  }

  String fixUpCaps(String name) {
      if (name != null && name.length() > 0)
        return name.substring(0, 1).toUpperCase()+name.toLowerCase().substring(1)

      return name
  }
  */
}
