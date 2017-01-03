class InvitationMailer < ApplicationMailer
  def invite(invitation, url)
    @email = invitation.email
    @url = invitation.generate_url(url)
    mail(to: @email, subject: "Turing School: Census Invitation")
  end
end
