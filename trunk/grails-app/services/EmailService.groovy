import org.apache.commons.mail.DefaultAuthenticator
import org.apache.commons.mail.SimpleEmail

class EmailService {

    def personService
    java.util.Random random = java.util.Random.newInstance()

    boolean transactional = false

    def sendEmailWithParticipation(Collection recipients, Event event, String fromEmail, String fromName, String subject, String body, String baseAppUrl) {

        Thread t = new Thread( {
            recipients.each { person ->
                if (person && person.email && person.email.indexOf('@') > -1) {
                    def sent = false;
                    def tries = 0;
                    while (!sent && tries++ < 10) {
                        try {
                            sendAppendedMessage event, fromEmail, fromName, person, subject, body, baseAppUrl
                            sent = true;
                        } catch (Exception x) {
                            int seconds = random.nextInt(60);
                            log.error "Error sending participation email to ${person.email}: ${x.message}.  Waiting ${seconds} seconds to retry"
                            Thread.sleep(1000*seconds);
                        }
                    }

                    if (!sent)
                        log.error("Unable to send participation email to ${person.email} after 10 tries.")
                }
                else if (log)
                    log.info("Could not send email to ${person}")
            }
        })

        t.run()
    }

    def sendVolunteerConfirmation(Position p, String baseAppUrl) {
        SimpleEmail email = createEmail("do-not-reply@highlandsvolunteers.org", "Highlands Volunteer Administrator")
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
        // gmail VERSION
        SimpleEmail email = new SimpleEmail(hostName: "smtp.gmail.com", smtpPort: 587,
                TLS: true, authenticator: new DefaultAuthenticator("edinahighlandsvolunteers", "mrhodney"))

        // James/Sendmail VERSION
        //SimpleEmail email = new SimpleEmail(hostName: "localhost", smtpPort: 25)
        
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