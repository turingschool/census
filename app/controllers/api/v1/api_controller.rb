module Api::V1
  class ApiController < ActionController::API
    before_action :doorkeeper_authorize!

    private

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def require_user_or_doorkeeper_authorize!
      current_user || doorkeeper_authorize!
    end
  end
end
