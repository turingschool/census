class InvitationMailerPreview < ActionMailer::Preview
  # FIXME(srt32): this import is polluting the mailer preview methods

  include Rails.application.routes.url_helpers

  def invite
    invitation = Invitation.last!
    invitation.update!(role: Role.find_or_create_by(name: "student"))
    InvitationMailer.invite(invitation, new_user_registration_url)
  end

  def invite_with_enroll
    invitation = Invitation.last!
    invitation.update!(role: Role.find_or_create_by(name: "invitee"))
    InvitationMailer.invite(invitation, new_user_registration_url)
  end
end
