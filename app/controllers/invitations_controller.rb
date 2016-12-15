class InvitationsController < ApplicationController
  before_action :invitation, only: [:destroy, :update]
  def new
    @invitation = Invitation.new
  end

  def create
    manager = InvitationManager.new(invitation_params, current_user)
    flash[manager.status] = manager.status_message
    if manager.status == :notice
      redirect_to admin_dashboard_path
    else
      redirect_to new_invitation_path
    end
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
