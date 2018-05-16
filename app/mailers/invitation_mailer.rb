class InvitationMailer < ApplicationMailer
  def invite(invitation, url)
    @email = invitation.email
    @url = invitation.generate_url(url)
    enroll_elligible = invitation.enroll_elligible?
    mail(
      to: @email,
      bcc: ['jeff@turing.io', 'erin@turing.io'],
      subject: "Welcome to Turing",
      template_name: enroll_elligible ? "invite_with_enroll" : "invite"
    )
  end
end
