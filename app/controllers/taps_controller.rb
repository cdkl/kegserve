class TapsController < ApplicationController
    before_action :set_tap, only: [:show, :edit, :update, :destroy]
    
    def index
        @taps = Tap.all
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
        # Assuming you want to edit the tap's beverage as well
        @beverage = @tap.beverage if @tap.beverage.present?
    end
    
    def create
        @tap = Tap.new(tap_params)
        if @tap.save
            redirect_to @tap, notice: 'Tap was successfully created.'
        else
            render :new
        end
    end
    
    def update
        if @tap.update(tap_params)
            redirect_to @tap, notice: 'Tap was successfully updated.'
        else
            render :edit
        end
    end
    
    def destroy
        @tap.destroy
            redirect_to taps_url, notice: 'Tap was successfully destroyed.'
    end
    
    private
    
    def set_tap
        @tap = Tap.find(params[:id])
    end
    
    def tap_params
        params.require(:tap).permit(:name, :location, :status)
    end
end
