module Api
  module V1
    class TapsController < ApplicationController
      before_action :set_tap, only: [ :show ]

      def index
        @taps = Tap.all
        render json: @taps.as_json(include: :beverage)
      end

      def show
        render json: @tap.as_json(include: :beverage)
      end

      private

      def set_tap
        @tap = Tap.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Tap not found" }, status: :not_found
      end

      def tap_params
        params.require(:tap).permit(:name, :beverage_id)
      end
    end
  end
end
