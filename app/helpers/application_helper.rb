module ApplicationHelper
  def logged_in?
    session['uid']
  end
end
