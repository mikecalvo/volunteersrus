import org.apache.commons.io.FileUtils;

class AttachmentController {

    def index = { }

    def view = {
        Attachment a = Attachment.get(Long.parseLong(params.id))

        byte[] fileData = FileUtils.readFileToByteArray(new File(a.fileLocation))
        response.contentType = a.mimeType
        response.outputStream << fileData
    }

    def delete = {
        Attachment a = Attachment.get(Long.parseLong(params.id))
        Event e = a.event

        // Cleanup the file
        File f = new File(a.fileLocation)
        if (f.exists())
            f.delete()
        int i = a.displayOrder
        e.removeFromAttachments(a)

        a.delete();

        e.attachments.each { if (it != null && it.displayOrder >= i) { it.displayOrder--;  } }
        e.save()

        flash.message = "Attachment removed"
        redirect(action: 'admin', id: e.id)
    }

    def up = {
        Attachment a = Attachment.get(Long.parseLong(params.id))
        Event e = a.event
        def i = a.displayOrder
        if (i > 0) {
            a.displayOrder--
            e.attachments.each {
                if (it && it != a && it.displayOrder == a.displayOrder)
                    it.displayOrder++
            }
            e.save()
        }
        redirect(action: 'admin', id: e.id)
    }

    def down = {
        Attachment a = Attachment.get(Long.parseLong(params.id))
        Event e = a.event
        def i = a.displayOrder
        if (i < e.attachments.size()-1) {
            a.displayOrder++
            e.attachments.each { if (it && it != a && it.displayOrder == a.displayOrder) it.displayOrder-- }
            e.save()
        }
        redirect(action: 'admin', id: e.id)
    }

    def admin = {
        Event e = Event.get(Long.parseLong(params.id))

        def sorted = e.attachments.findAll { it != null}
        [event: e, currentCrumb:'Edit Attachments', sorted: sorted.sort {it.displayOrder}]
    }

    def attach = {
        Event e = Event.get(Long.parseLong(params.id))
        if (e) {
            def file = request.getFile('attachmentFile')
            if (file && !file.empty) {
                Attachment a = new Attachment(name: params.attachmentName, mimeType: file.contentType, displayOrder: e.attachments.size())
                e.addToAttachments(a)
                e.save()
                a.save()
                def fileName = System.getProperty("java.io.tmpdir")+"/signmeup-attachment-${a.id}"
                file.transferTo(new java.io.File(fileName))
                flash.message = "Attachment ${a.name} added"
            } else {
                flash.error = "No file attached"
            }

            redirect(action: 'admin', id: e.id)
        } else {
            flash.error = "No event id specified"
            redirect(action: 'available')
        }
    }
}