class PlayedGamesController < ApplicationController
  before_action :set_played_game, only: [:show, :edit, :update, :destroy]

  # GET /played_games
  # GET /played_games.json
  def index
    @played_games = PlayedGame.all
  end

  # GET /played_games/1
  # GET /played_games/1.json
  def show
  end

  # GET /played_games/new
  def new
    @played_game = PlayedGame.new
  end

  # GET /played_games/1/edit
  def edit
  end

  # POST /played_games
  # POST /played_games.json
  def create
    @played_game = PlayedGame.new(played_game_params)

    respond_to do |format|
      if @played_game.save
        format.html { redirect_to @played_game, notice: 'Played game was successfully created.' }
        format.json { render :show, status: :created, location: @played_game }
      else
        format.html { render :new }
        format.json { render json: @played_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /played_games/1
  # PATCH/PUT /played_games/1.json
  def update
    respond_to do |format|
      if @played_game.update(played_game_params)
        format.html { redirect_to @played_game, notice: 'Played game was successfully updated.' }
        format.json { render :show, status: :ok, location: @played_game }
      else
        format.html { render :edit }
        format.json { render json: @played_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /played_games/1
  # DELETE /played_games/1.json
  def destroy
    @played_game.destroy
    respond_to do |format|
      format.html { redirect_to played_games_url, notice: 'Played game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_played_game
      @played_game = PlayedGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def played_game_params
      params.require(:played_game).permit(:game_id, :player_id, :team_id, :formation_id, :starting_position, :rsvp, :red_card_minute, :yellow_card_minute, :card_details, :team_comments)
    end
end
