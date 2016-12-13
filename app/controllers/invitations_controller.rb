class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    invitation_params[:email].each do |email|
      # Invitation.new
      # send_email(email)
    end
  end

  private
    def invitation_params
      whitelist = params.require(:invitation).permit(:email)
      whitelist[:group] = params[:group]
      return whitelist
    end

end
