module ApplicationHelper
  def invited?
    !!session[:invitation_code]
  end

  def user_is_admin?
    current_user.has_role?("admin") if current_user
  end

  def user_is_staff?
    current_user.has_role?("staff") if current_user
  end
end
