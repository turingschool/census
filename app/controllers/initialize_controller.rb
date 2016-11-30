class InitializeController < ApplicationController
  def new
    @user = User.new
  end
end
