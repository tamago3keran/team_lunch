class Office
  include Mongoid::Document
  include Mongoid::Timestamps

  field :address, type: String
  field :latitude, type: Float
  field :longitude, type: Float
end
