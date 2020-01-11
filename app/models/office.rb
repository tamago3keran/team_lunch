class Office
  include Mongoid::Document
  include Mongoid::Timestamps

  field :address, type: String
  field :latitude, type: Float
  field :longitude, type: Float

  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
