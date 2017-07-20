module ApplicationHelper
  def invited?
    !!session[:invitation_code]
  end

  def user_is_admin?
    current_user.roles.where(name: 'admin').exists? if current_user
  end

  def user_is_staff?
    current_user.roles.where(name: 'staff').exists? if current_user
  end

end
