class PositionTests extends GroovyTestCase {
    public void testFormattedTimeFrameBothAm() {
        Position p = new Position()
        p.setStartTime 1000
        p.setEndTime 1100

        assertEquals "10:00 - 11:00 AM", p.getFormattedTimeFrame()
    }

    public void testFormattedTimeFrameBothPm() {
        Position p = new Position()
        p.setStartTime 1300
        p.setEndTime 1600

        assertEquals "1:00 - 4:00 PM", p.getFormattedTimeFrame()
    }

    public void testMorningWithAfterNoon() {
        Position p = new Position()
        p.setStartTime 500
        p.setEndTime 1700

        assertEquals("5:00 AM - 5:00 PM", p.getFormattedTimeFrame())
    }

    public void testTypicalFractionalHours() {
        Position p = new Position()
        p.setStartTime 925; p.setEndTime 975
        assertEquals("9:15 - 9:45 AM", p.getFormattedTimeFrame())

        p.setStartTime 950; p.setEndTime 1025
        assertEquals("9:30 - 10:15 AM", p.getFormattedTimeFrame())

        p.setStartTime 575; p.setEndTime 1950
        assertEquals("5:45 AM - 7:30 PM", p.getFormattedTimeFrame())
    }
}
