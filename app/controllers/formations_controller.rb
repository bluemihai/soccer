class FormationsController < ApplicationController
  before_action :set_formation, only: [:show, :edit, :update, :destroy]

  def index
    @formations = Formation.all
  end

  def show
  end

  def new
    @formation = Formation.new
  end

  def edit
  end

  def create
    @formation = Formation.new(formation_params)

    respond_to do |format|
      if @formation.save
        format.html { redirect_to @formation, notice: 'Formation was successfully created.' }
        format.json { render :show, status: :created, location: @formation }
      else
        format.html { render :new }
        format.json { render json: @formation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @formation.update(formation_params)
        format.html { redirect_to @formation, notice: 'Formation was successfully updated.' }
        format.json { render :show, status: :ok, location: @formation }
      else
        format.html { render :edit }
        format.json { render json: @formation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @formation.destroy
    respond_to do |format|
      format.html { redirect_to formations_url, notice: 'Formation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_formation
      @formation = Formation.find(params[:id])
    end

    def formation_params
      params.require(:formation).permit(:name, :image_url, :positions, 
        :comments, :one, :two, :three, :four, :five, :six)
    end
end
