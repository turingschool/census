class InvitationMailer < ApplicationMailer
  def invite(invitation, url, is_resend: false)
    @salutation_name = invitation.name
    @url = invitation.generate_url(url)
    enroll_elligible = invitation.enroll_elligible? && !is_resend

    mail(
      bcc: ['jeff@turing.edu', 'erin@turing.edu'],
      from: '"Turing School" <admissions@turing.edu>',
      subject: enroll_elligible ? "Welcome to Turing, #{@salutation_name}" : "Welcome to Turing",
      template_name: enroll_elligible ? "invite_with_enroll" : "invite",
      to: invitation.email
    )
  end
end
