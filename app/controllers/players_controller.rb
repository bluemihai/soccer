class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    if @team = Team.find_by_id(params[:team_id])
      @active_or_pending = @team.players.active_or_pending
      @inactive = @team.players.inactive
    end

    if params.has_key?(:include_inactive)
      @players = Player.order(:jersey)
    else
      @players = Player.active_or_pending
    end
  end

  def show
  end

  def new
    @player = Player.new
  end

  def edit
  end

  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        if admin_or_manager?
          msg = "You have successfully added #{@player.name} to your team, #{@player.team.name}."
          format.html { redirect_to @player.team, notice: msg}
          format.json { render :show, status: :created, location: @player }
        else
          format.html { redirect_to registration_path, notice: "Your request to join #{@player.team.name} has been received.  The team manager will double-check your league registration, collect your team dues and approve your request." }
          format.json { render :show, status: :created, location: @player }          
        end
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:first, :last, :email, :phone, 
        :keeper, :attendance_estimate, :ideal_minutes, :why, :paid, :ebssl_card,
        :jersey, :status, :city, :team_id, :active, :user_id, :approved,
        :position, :invited, :name, :position_request, :has_jersey)
    end
end
