class AdminController < ApplicationController
  before_action :is_admin?

  def is_admin?
    unless current_user && current_user.has_role?('admin')
      render :file => 'public/404.html', :status => :not_found, :layout => false
    end
  end
end
