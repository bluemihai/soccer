class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  def index
    @users = User.all
  end

  def show
    unless current_user.admin?
      unless @user == current_user
        redirect_to safe_back, :alert => "Access denied."
      end
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(secure_params)
      redirect_to safe_back, :notice => "User updated."
    else
      redirect_to safe_back, :alert => "Unable to update user."
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to safe_back, :alert => "Access denied."
    end
  end

  def secure_params
    if @user == current_user
      params.require(:user).permit(:email)
    elsif current_user.admin?
      params.require(:user).permit(:role)
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end
