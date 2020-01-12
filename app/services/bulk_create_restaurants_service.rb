class BulkCreateRestaurantsService < BaseService
  include Math

  def call
    return false unless office = Office.first.presence
    Restaurant::CATEGORIES.each do |category|
      Google::PlaceSearcher.near_by_search(office.latitude, office.longitude, category).each do |result|
        next if Restaurant.where(google_place_id: result["place_id"]).exists?
        response = Google::PlaceSearcher.detail_search(result["place_id"])
        Restaurant.create(
          address: response["formatted_address"],
          category: category,
          distance: get_distance(office, response["geometry"]["location"]["lat"], response["geometry"]["location"]["lng"]),
          google_maps_url: response["url"],
          google_place_id: response["place_id"],
          google_rating: response["rating"],
          latitude: response["geometry"]["location"]["lat"],
          longitude: response["geometry"]["location"]["lng"],
          name: response["name"],
          website_url: response["website"]
        )
      end
    end
  end

  private
    def get_distance(office, restaurant_lat, restaurant_lng)
      y1, x1, y2, x2 = [office.latitude, office.longitude, restaurant_lat, restaurant_lng].map { |v| v * PI / 180 }
      earth_r = 6378140 # m
      cos_theta = sin(y1) * sin(y2) + cos(y1) * cos(y2) * cos(x2 - x1)
      earth_r * acos(cos_theta)
    end
end
