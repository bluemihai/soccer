
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only, :except => [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    unless current_user.admin?
      unless @user == current_user
        redirect_to safe_back, :alert => "Access denied."
      end
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = RegistrationPdf.new(@user, view_context)
        send_data pdf.render, {
          filename: "registration_#{@user.id}.pdf", 
          type: "application/pdf"
        }
      end
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      if @user.player
        # ManagerMailer.user_updated_email(@user).deliver_later if @user.manager
        # UserMailer.welcome_email({user: @user, invited: true}).deliver_later
        redirect_to @user, :notice => "Your league registration form was saved.  Please update your team profile for #{@user.player.team.name}."
      else
        # UserMailer.welcome_email({user: @user, invited: false}).deliver_later
        redirect_to @user, :notice => "Your league registration form was saved.  You may now request to join a team."
      end
    else
      render :edit
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

  def user_params
    if current_user && current_user.admin?
      params.require(:user).permit(:dob, :name, :role,
        :first_name, :middle_name, :last_name, :day_phone, :evening_phone,
        :email, :photo, :license_photo, :dl_license_no, :dl_issuing_state,
        :passport_no, :passport_country, :liability_waiver_agreed, :pass_id,
        :manager_confirmation, :manager_signature, :manager_signature_date,
        :league_past_when, :league_played_before, :league_past_team_name,
        :league_past_your_name, :manager_message)
    else
      params.require(:user).permit(:dob, :name,
        :first_name, :middle_name, :last_name, :day_phone, :evening_phone,
        :email, :photo, :license_photo, :dl_license_no, :dl_issuing_state,
        :passport_no, :passport_country, :liability_waiver_agreed, :pass_id,
        :manager_confirmation, :manager_signature, :manager_signature_date,
        :league_past_when, :league_played_before, :league_past_team_name,
        :league_past_your_name, :manager_message)
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end
