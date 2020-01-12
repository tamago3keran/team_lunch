class Restaurants::BulkCreatesController < ApplicationController
  def create
    redirect_to new_office_path if Office.blank?
    BulkCreateRestaurantsService.call
    redirect_to restaurants_path
  end
end
