/** A document attached to an event. */
class Attachment {

    static belongsTo = [event:Event]

    static constraints = {
        name(maxSize: 100)
        mimeType(maxSize: 32)
    }
    static transients = [ 'fileLocation' ]

    String name
    String mimeType
    int displayOrder

    String getFileLocation() {
        System.getProperty("java.io.tmpdir")+"/signmeup-attachment-${id}"
    }
}