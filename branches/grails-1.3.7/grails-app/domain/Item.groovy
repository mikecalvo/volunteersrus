class Item
{
  // static belongsTo = []
  static constraints = {
      name()
      description(nullable: true)
  }

  String name
  String description

  String toString ()
  {
    return "${name} (${id})"
  }
}
