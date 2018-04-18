class Api::V1::Admin::AdminController < Api::V1::ApiController
  before_action do
    doorkeeper_authorize! :admin
  end
end
