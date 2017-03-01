class Admin::DashboardController < AdminController
  def show
    @invitations = Invitation.where(:status => 'mailed')
  end
end
