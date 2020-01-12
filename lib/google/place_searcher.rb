require "net/http"
require "uri"

module Google
  class PlaceSearcher
    GOOGLE_PLACE_NEAR_BY_SEARCH_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    GOOGLE_PLACE_DETAIL_SEARCH_URL = "https://maps.googleapis.com/maps/api/place/details/json"

    def self.near_by_search(lat, lng, category)
      uri = URI.parse(GOOGLE_PLACE_NEAR_BY_SEARCH_URL)
      next_page_token, results = "", []
      while true do
        uri.query = next_page_token.present? ? URI.encode_www_form(build_near_by_search_next_page_params(next_page_token))
                                             : URI.encode_www_form(build_near_by_search_params(lat, lng, category))
        request = Net::HTTP::Get.new(uri.request_uri)
        response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(request) }

        json = JSON.parse(response.body)
        json["results"].each { |result| results << result }
        json["next_page_token"] ? next_page_token = json["next_page_token"] : break
        sleep(2) # receive response without next_page_token by send request too eary
      end
      results
    end

    def self.detail_search(google_place_id)
      uri = URI.parse(GOOGLE_PLACE_DETAIL_SEARCH_URL)
      uri.query = URI.encode_www_form(build_detail_search_params(google_place_id))
      request = Net::HTTP::Get.new(uri.request_uri)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(request) }
      JSON.parse(response.body)["result"]
    end

    private
      def self.build_near_by_search_params(lat, lng, category)
        { location: "#{lat},#{lng}", type: "restaurant", radius: 800, keyword: category, language: Settings.google.language, key: Settings.google.api_key }
      end

      def self.build_near_by_search_next_page_params(page_token)
        { pagetoken: page_token, key: Settings.google.api_key }
      end

      def self.build_detail_search_params(google_place_id)
        { place_id: google_place_id, language: Settings.google.language, key: Settings.google.api_key }
      end
  end
end
