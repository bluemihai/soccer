class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :admin_or_manager?
  helper_method :admin_or_manager_only!

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def safe_back
      request.env["HTTP_REFERER"] || root_url
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def admin_or_manager?
      current_user && (current_user.admin? || current_user.manager?)
    end

    def admin_or_manager_only!
      unless current_user && (current_user.admin? || current_user.manager?)
        redirect_to safe_back, :alert => "Access denied."
      end
    end


end
