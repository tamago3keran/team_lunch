class Restaurant
  include Mongoid::Document
  include Mongoid::Timestamps

  CATEGORIES = %w(japanese chinese korean french italian others)

  field :address, type: String
  field :category, type: String, default: "others"
  field :distance, type: Integer
  field :google_maps_url, type: String
  field :google_place_id, type: String
  field :google_rating, type: Float, default: 0
  field :latitude, type: Float
  field :longitude, type: Float
  field :name, type: String
  field :website_url, type: String

  validates :address, presence: true
  validates :category, inclusion: { in: CATEGORIES }, presence: true
  validates :distance, presence: true
  validates :google_maps_url, presence: true
  validates :google_place_id, presence: true, uniqueness: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :name, presence: true
end
