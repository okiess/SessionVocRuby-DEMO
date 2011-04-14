class SessionsController < ApplicationController
  def new; end
  
  def create
    if not params[:uid].blank? and not params[:password].blank?
      success = false
      success = session.login(session['sid'], params[:uid], params[:password])
      redirect_to root_url and return if success
    end
    @notice = "Login gescheitert!"
    render :action => 'new'
  end

  def destroy
    session.logout(session['sid'])
    redirect_to root_url
  end
end
