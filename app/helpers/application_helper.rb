module ApplicationHelper
  def invited?
    !!session[:invitation_code]
  end
end
