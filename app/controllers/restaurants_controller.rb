class RestaurantsController < ApplicationController
  def index
    if params[:search_word]
      @restaurants = Restaurant.where(name: /#{Regexp.escape(params[:search_word])}/i).asc(:distance)
    else
      @restaurants = Restaurant.all.asc(:distance)
    end
  end
end
