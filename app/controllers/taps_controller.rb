class TapsController < ApplicationController
  before_action :set_tap, only: [ :show, :edit, :update, :destroy ]

  def index
    @taps = Tap.all
    @beverages = Beverage.all
  end

  def show
    set_tap
    # Assuming you want to display the tap's beverage as well
    @beverage = @tap.beverage if @tap.beverage.present?
  end

  def new
    @tap = Tap.new
  end

  def edit
    set_tap
    @beverages = Beverage.all
  end

  def create
    @tap = Tap.new(tap_params)
    if @tap.save
      redirect_to @tap, notice: "Tap was successfully created."
    else
      render :new
    end
  end

  def update
    if @tap.update(tap_params)
      if request.referrer&.include?("/taps") && !request.referrer&.include?("/taps/#{@tap.id}")
        redirect_back(fallback_location: taps_path, notice: "Tap was successfully updated.")
      else
        redirect_to @tap, notice: "Tap was successfully updated."
      end
    else
      render :edit
    end
  end

  def destroy
    @tap.destroy
    redirect_to taps_url, notice: "Tap was successfully destroyed."
  end

  private

  def set_tap
    @tap = Tap.find(params[:id])
  end

  def tap_params
    params.require(:tap).permit(:name, :beverage_id)
  end
end
