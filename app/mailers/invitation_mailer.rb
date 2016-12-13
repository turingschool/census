class InvitationMailer < ApplicationMailer
  def invite(invitation)
    @email = invitation.email
    @url = invitation.generate_url
    mail(to: @email, subject: "Turing School: Census Invitation")
  end
end
