class EventTests extends GroovyTestCase
{
  public void testAddingAPosition () {
      Event e = new Event()
      Position p = new Position(title: 'Boss Man')
      e.addToPositions(p)
      // assertEquals 1, e.getPositions().size()
  }
}
