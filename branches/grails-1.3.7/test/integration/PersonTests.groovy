class PersonTests extends GroovyTestCase
{
  public void testSetName() {
      Person p = new Person();

      p.setName("Joe Strummer")

      assertEquals "Joe", p.firstName
      assertEquals "Strummer", p.lastName
  }
}
