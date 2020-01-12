class RestaurantsController < ApplicationController
  before_action :load_resource, only: [:index]

  def index; end

  private
    def load_resource
      case params[:action].to_sym
      when :index
        @restaurants = Restaurant.all
      end
    end
end
