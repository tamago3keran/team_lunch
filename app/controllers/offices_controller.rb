class OfficesController < ApplicationController
  before_action :load_resource, only: [:show, :new, :edit, :update]

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

  def edit; end

  def update
    location = Google::Geocoder.location_search(office_params[:address])
    if @office.update_attributes(address: office_params[:address], latitude: location["lat"], longitude: location["lng"])
      redirect_to office_path
    else
      render :edit
    end
  end

  private
    def load_resource
      case params[:action].to_sym
      when :show, :edit, :update
        @office = Office.first
      when :new
        @office = Office.new
      end
    end

    def office_params
      params.require(:office).permit(:address)
    end
end
