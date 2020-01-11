class OfficesController < ApplicationController
  before_action :load_resource, only: [:show, :new]

  def show
    redirect_to new_office_path if @office.blank?
  end

  def new; end

  def create
    location = Google::Geocoder.location_search(office_params[:address])
    office = Office.new(address: office_params[:address], latitude: location["lat"], longitude: location["lng"])
    if office.save
      redirect_to office_path
    else
      render :new
    end
  end

  private
    def load_resource
      case params[:action].to_sym
      when :show
        @office = Office.first
      when :new
        @office = Office.new
      end
    end

    def office_params
      params.require(:office).permit(:address)
    end
end
