class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    if params[:team_id]
      @games = Game.for_team_id(params[:team_id])
    elsif params[:division_id]
      @games = Game.where(division_id: params[:division_id]).order(:division_id, :week)
    else
      @games = Game.order(:division_id, :week)
    end
  end

  def show
  end

  def new
    @game = Game.new
    set_teams
  end

  def edit
    set_teams
  end

  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to new_division_game_path(@game.division), notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        set_teams
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        set_teams
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:home_id, :away_id, :kickoff, :field_id, 
        :referees_report, :context, :referee_id, :status, :week, :kickoff_time,
        :division_id, :home_score, :away_score)
    end

    def set_teams
      if division = Division.find_by_id(params[:division_id])
        @teams = division.teams.order(:name)
      else
        @teams = Team.order(:name)
      end
    end
end
