class Api::V1::Admin::AdminController < Api::V1::ApiController
  skip_before_action :doorkeeper_authorize!
  before_action :require_admin_user_or_doorkeeper_authorize_admin_scope

  private

  def require_admin_user_or_doorkeeper_authorize_admin_scope
    (current_user && current_user.has_role?("admin")) || doorkeeper_authorize!(:admin)
  end
end
