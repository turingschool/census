class InvitationMailer < ApplicationMailer
  def invite(invitation, url)
    @salutation_name = invitation.name
    @url = invitation.generate_url(url)
    enroll_elligible = invitation.enroll_elligible?
    mail(
      to: invitation.email,
      bcc: ['jeff@turing.io', 'erin@turing.io'],
      subject: enroll_elligible ? "Welcome to Turing, #{@salutation_name}" : "Welcome to Turing",
      template_name: enroll_elligible ? "invite_with_enroll" : "invite"
    )
  end
end
