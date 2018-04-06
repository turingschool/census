class Api::V1::Admin::BaseController < Api::V1::ApiController

  def require_admin
    current_user && current_user.has_role?("admin") || doorkeeper_authorize!
  end


end
