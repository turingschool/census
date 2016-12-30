class InvitationManager
  attr_reader :emails,
              :bad_emails

  def initialize(params, user, url)
    @role = Role.find_by(name: params[:role])
    @emails = params[:email].split(", ")
    @user = user
    @url = url
    @bad_emails = process_emails if @role
  end

  def status_message
    return no_role if @role.nil?
    return good if @bad_emails.empty?
    return bad if !@bad_emails.empty?
  end

  def status
    @role && @bad_emails.empty? ? :notice : :error
  end

  def success?
    status == :notice
  end

  private

    def process_emails
      emails.reduce([]) do |bad_emails, email|
        invitation = @user.invitations.new(email: email, status: 0, role: @role)
        invitation.save ? invitation.send!(@url) : bad_emails << email
        bad_emails
      end
    end

    def good
      "Your emails are being sent. You will receive a confirmation once " + \
      "this process is complete."
    end

    def bad
      "#{emails.count - bad_emails.count} out of #{emails.count} invites " + \
      "sent. Error sending #{bad_emails.join(', ')}."
    end

    def no_role
      "Select a role."
    end
end
