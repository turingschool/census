class InvitationManager
  attr_reader :emails,
              :bad_emails

  def initialize(params, user, url)
    @cohort = params[:cohort] || ""
    @role = find_role(params[:role])
    @emails = params[:email].split(",").map{|e| e.strip}
    @user = user
    @url = url
    @bad_emails = process_emails if @role
  end

  def status_message
    return no_cohort if @role.nil?
    return good if @bad_emails.empty?
    return bad if !@bad_emails.empty?
  end

  def status
    @role && @bad_emails.empty? ? :success : :danger
  end

  def success?
    status == :success
  end

  private

    def find_role(role_name)
      if role_name == "Student" && Cohort.find_by_name(@cohort)
        set_role_for_student
      elsif role_name == "Mentor"
        set_role_for_mentor
      elsif role_name == "Staff"
        set_role_for_admin
      elsif role_name == "Invitee"
        set_role_for_invitee
      end
    end

    def set_role_for_student
      cohort_status = Cohort.find_by_name(@cohort).status
      Role.find_by(name: role_key[cohort_status])
    end

    def set_role_for_mentor
      Role.find_by(name: "mentor")
    end

    def set_role_for_admin
      Role.find_by(name: "staff")
    end

    def set_role_for_invitee
      Role.find_by(name: Role::ENROLL_ELLIGIBLE_ROLE_NAME)
    end

    def role_key
      {
        "open" => "active student",
        "closed" => "graduated"
      }
    end

    def process_emails
      emails.reduce([]) do |bad_emails, email|
        invitation = @user.invitations.new(email: email, status: 0, role: @role)
        invitation.cohort_id = Cohort.find_by_name(@cohort).id unless @cohort.empty?
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

    def no_cohort
      "You must select a cohort for students."
    end
end
