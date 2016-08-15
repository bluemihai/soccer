class SessionsController < ApplicationController

  def new
    if params[:provider] == 'facebook'
      redirect_to '/auth/facebook'
    else
      redirect_to '/auth/google_oauth2'
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    # TODO: Create separate authorizations table and reintroduce the uid, for (I think) better security
    # user = User.where(:provider => auth['provider'],
    #                   :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    user = User.where(email: auth['info']['email']).first || User.create_with_omniauth(auth)
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
