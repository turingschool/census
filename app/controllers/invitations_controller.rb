class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    invitation_params[:email].split(", ").each do |email|
      invitation = current_user.invitations.new(email: email, status: 0)
      invitation.send! if invitation.save
      # add sad path!
    end
    redirect_to admin_dashboard_path
  end

  private
    def invitation_params
      whitelist = params.require(:invitation).permit(:email)
      whitelist[:group] = params[:group]
      return whitelist
    end

end
