class Admin::Roles::UsersController < ApplicationController
  def edit
    @roles = Role.all
  end
end
