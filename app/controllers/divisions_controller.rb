class DivisionsController < ApplicationController
  before_action :set_division, only: [:show, :edit, :update, :destroy]

  def index
    @divisions = Division.order(:id)
  end

  def show
    @teams = @division.standings
  end

  def new
    @division = Division.new
  end

  def edit
  end

  def create
    @division = Division.new(division_params)

    respond_to do |format|
      if @division.save
        format.html { redirect_to @division, notice: 'Division was successfully created.' }
        format.json { render :show, status: :created, location: @division }
      else
        format.html { render :new }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @division.update(division_params)
        format.html { redirect_to @division, notice: 'Division was successfully updated.' }
        format.json { render :show, status: :ok, location: @division }
      else
        format.html { render :edit }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @division.destroy
    respond_to do |format|
      format.html { redirect_to divisions_url, notice: 'Division was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_division
      @division = Division.find(params[:id])
    end

    def division_params
      params.require(:division).permit(:letter, :age)
    end
end
