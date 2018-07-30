class InvitationMailerPreview < ActionMailer::Preview

  def invite
    invitation = Invitation.last!
    invitation.update!(role: Role.find_or_create_by(name: "student"))
    InvitationMailer.invite(invitation, invite_url)
  end

  def invite_with_enroll
    invitation = Invitation.last!
    invitation.update!(role: Role.find_or_create_by(name: Role::ENROLL_ELLIGIBLE_ROLE_NAME))
    InvitationMailer.invite(invitation, invite_url)
  end

  def invite_with_enroll_as_resend
    invitation = Invitation.last!
    invitation.update!(role: Role.find_or_create_by(name: Role::ENROLL_ELLIGIBLE_ROLE_NAME))
    InvitationMailer.invite(invitation, invite_url, is_resend: true)
  end

  private

  def invite_url
    "localhost:#{ENV.fetch('PORT', 3010)}/users/sign_up"
  end
end
