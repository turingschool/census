class Admin::Roles::UsersController < AdminController
  def edit
    @roles = Role.all
  end
end
