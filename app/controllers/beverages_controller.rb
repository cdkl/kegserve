class BeveragesController < ApplicationController
  before_action :set_beverage, only: [ :show, :edit, :update, :destroy ]

  def index
    @beverages = Beverage.all
  end

  def show
    set_beverage
  end

  def new
    @beverage = Beverage.new
  end

  def edit
    set_beverage
  end

  def create
    @beverage = Beverage.new(beverage_params)
    if @beverage.save
      redirect_to @beverage, notice: "Beverage was successfully created."
    else
      render :new
    end
  end

  def update
    if @beverage.update(beverage_params)
      redirect_to @beverage, notice: "Beverage was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @beverage.destroy
    redirect_to beverages_url, notice: "Beverage was successfully destroyed."
  end

  private

  def set_beverage
    @beverage = Beverage.find(params[:id])
  end

  def beverage_params
    params.require(:beverage).permit(:name, :style, :ibu, :abv)
  end
end
