class RestaurantsController < ApplicationController
  before_action :load_resource

  def show; end

  def index
    if params[:search_word]
      @restaurants = Restaurant.where(name: /#{Regexp.escape(params[:search_word])}/i).asc(:distance)
    else
      @restaurants = Restaurant.all.asc(:distance)
    end
  end

  def edit; end

  def update
    if @restaurant.update_attributes(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  private
    def load_resource
      case params[:action].to_sym
      when :show, :edit, :update
        @restaurant = Restaurant.find(params[:id])
      end
    end

    def restaurant_params
      params.require(:restaurant).permit(:category, :name)
    end
end
