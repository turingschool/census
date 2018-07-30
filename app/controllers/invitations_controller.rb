class InvitationsController < ApplicationController
  before_action :invitation, only: [:destroy, :update]
  authorize_resource

  def index
    @invitations = current_user.invitations.last_five_minutes
  end

  def new
    @invitation = Invitation.new
    @cohorts = Cohort.all.map{ |c| c.name }.unshift("")
  end

  def create
    manager = InvitationManager.new(invitation_params,
                                    current_user,
                                    new_user_registration_url)
    flash[manager.status] = manager.status_message
    redirect_to manager.success? ? invitations_path : new_invitation_path
  end

  def update
    @invitation.send!(new_user_registration_url, is_resend: true)
    flash[:success] = "Invitation Re-Sent."
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
      whitelist[:cohort] = params[:cohort]
      return whitelist
    end

    def invitation
      @invitation ||= Invitation.find(params[:id])
    end
end
