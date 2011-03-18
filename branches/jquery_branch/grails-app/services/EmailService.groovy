import org.apache.commons.mail.DefaultAuthenticator
import org.apache.commons.mail.SimpleEmail

class EmailService {

    def personService

    boolean transactional = false
    private static MAIL_SERVER = "smtp.gmail.com";
    private static MAIL_SERVER_PORT = 587;

    def sendEmailWithParticipation(Collection recipients, Event event, String fromEmail, String fromName, String subject, String body, String baseAppUrl) {

        Thread t = new Thread( {
            recipients.each { person->
                if (person && person.email && person.email.indexOf('@') > -1)
                    sendAppendedMessage event, fromEmail, fromName, person, subject, body, baseAppUrl
                else if (log)
                    log.info("Could not send email to ${person}")
            }
        })

        t.run()
    }

    def sendVolunteerConfirmation(Position p, String baseAppUrl) {
        SimpleEmail email = createEmail(p.event.administrator.email, p.event.administrator.name)
        email.addTo p.volunteer.email, p.volunteer.name
        email.addCc p.event.administrator.email, p.event.administrator.name
        email.setSubject "Edina Highlands Elementary Volunteer Signup Confirmation"
        email.setMsg """${p.volunteer.firstName},

Thanks for volunteering as a ${p.title} for the ${p.event.name}.
The details about your position are available at
${baseAppUrl}/position/confirmation/${p.id}.

Regards
The Highlands Volunteer Committee
"""
        email.send()
    }

    def sendDonationConfirmation(ItemDonation i, String baseAppUrl) {
        SimpleEmail email = createEmail(i.donation.event.administrator.email, i.donation.event.administrator.name)
        email.addTo i.donor.email, i.donor.name
        email.addCc i.donation.event.administrator.email, i.donation.event.administrator.name
        email.setSubject "Edina Highlands Elementary Donation Signup Confirmation"
        email.setMsg """${i.donor.firstName},

Thanks for offering to donate ${i.quantity} ${i.donation.item.name} for the ${i.donation.event.name}.
The details about your donation are available at
${baseAppUrl}/donation/confirmation/${i.id}.

Regards
The Highlands Volunteer Committee
"""
        email.send();

    }

    private SimpleEmail createEmail(String fromAddress, String fromName) {
        SimpleEmail email = new SimpleEmail(hostName: MAIL_SERVER, smtpPort: MAIL_SERVER_PORT,
                TLS: true, authenticator: new DefaultAuthenticator("edinahighlandsvolunteers", "mrhodney"))
        email.setFrom fromAddress, fromName
        return email
    }

    private def sendAppendedMessage(event, fromEmail, fromName, person, subject, message, baseAppUrl) {
        SimpleEmail email = createEmail(fromEmail, fromName)
        email.addTo person.email, person.name
        email.setSubject subject

        def appendedMessage = message

        def pos = personService.getPositionsVolunteeredFor(event, person)
        if (pos.size() > 0){
            appendedMessage +="\n\nYou have volunteered for the following positions:"
            pos.each { position->
                appendedMessage += "\n${position.title}: ${baseAppUrl}/position/confirmation/${position.id}"
            }
        }
        def don = personService.getItemsDonatedBy(event, person)
        if (don.size() > 0) {
            appendedMessage +="\n\nYou have signed up to donate the following items:"
            personService.getItemsDonatedBy(event, person).each { d->
                appendedMessage += "\n${d.donation.item.name}: ${baseAppUrl}/donation/confirmation/${d.id}"
            }
        }

        email.setMsg appendedMessage
        email.send()
    }

}