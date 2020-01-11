class OfficesController < ApplicationController
  before_action :load_resource, only: [:new]

  def new; end

  def create
    location = Google::Geocoder.location_search(office_params[:address])
    Office.create(address: office_params[:address], latitude: location["lat"], longitude: location["lng"])
  end

  private
    def load_resource
      case params[:action].to_sym
      when :new
        @office = Office.new
      end
    end

    def office_params
      params.require(:office).permit(:address)
    end
end
