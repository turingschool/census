class InvitationMailer < ApplicationMailer
  def invite(invitation, url)
    @email = invitation.email
    @url = invitation.generate_url(url)
    enroll_elligible = invitation.enroll_elligible?
    mail(
      to: @email,
      subject: "Turing School: Census Invitation",
      template_name: enroll_elligible ? "invite_with_enroll" : "invite"
    )
  end
end
