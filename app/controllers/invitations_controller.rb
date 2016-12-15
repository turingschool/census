class InvitationsController < ApplicationController
  before_action :invitation, only: [:destroy, :update]
  def new
    @invitation = Invitation.new
  end

  def create

    # manager = InvitationManager.new(invitation_params)
    # result = manager.create
    # flash[result.status] = result.message
    # redirect_to result.path


    go_back unless invitation_includes_a_role?
    emails = invitation_params[:email].split(", ")
    bad_emails = []
    emails.each do |email|
      invitation = current_user.invitations.new(email: email, status: 0)
      if invitation.save
        invitation.send!
      else
        bad_emails << email
      end
    end
    if bad_emails.empty?
      flash[:notice] = "Your emails are being sent. You will receive a confirmation once this process is complete."
    else
      flash[:error] = error_message(emails, bad_emails)
    end
    redirect_to admin_dashboard_path
  end

  def update
    @invitation.send!
    redirect_to admin_dashboard_path
  end

  def destroy
    @invitation.destroy
    redirect_to admin_dashboard_path
  end

  private
    def invitation_params
      whitelist = params.require(:invitation).permit(:email)
      whitelist[:role] = params[:role]
      return whitelist
    end

    def invitation
      @invitation ||= Invitation.find(params[:id])
    end

    def error_message(emails, bad_emails)
      "#{emails.count - bad_emails.count} out of #{emails.count} invites " + \
      "sent. Error sending #{bad_emails.join(', ')}."
    end

    def invitation_includes_a_role?
      !!params[:invitation][:role]
    end

    def go_back
      flash[:error] = "Select a role."
      redirect_to new_invitation_path(invitation: { emails: params[:invitation][:emails] })
    end
end
