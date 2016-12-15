class InvitationsController < ApplicationController
  before_action :invitation, only: [:destroy, :update]
  def new
    @invitation = Invitation.new
  end

  def create
    invitation_params[:email].split(", ").each do |email|
      invitation = current_user.invitations.new(email: email, status: 0)
      invitation.send! if invitation.save
      # add sad path!
    end
    flash[:notice] = "Your emails are being sent. You will receive a confirmation once this process is complete."
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
      whitelist[:group] = params[:group]
      return whitelist
    end

    def invitation
      @invitation ||= Invitation.find(params[:id])
    end
end
