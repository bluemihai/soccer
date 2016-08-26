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
    if user = User.find_by(email: auth['info']['email'])
      reset_session
      session[:user_id] = user.id
      redirect_to user, :notice => 'Signed in!  Welcome back...'
    else
      user = User.create_with_omniauth(auth)
      reset_session
      session[:user_id] = user.id
      if player = Player.find_by(email: auth['info']['email'])
        player.update(user_id: user.id)
        redirect_to edit_user_path(user), :notice => 'Signed in, and team invitation found!  Please complete your league registration here.'
      else
        redirect_to edit_user_path(user), :notice => 'Signed in!  Please complete your league registration here, then request to join a team.'
      end
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
