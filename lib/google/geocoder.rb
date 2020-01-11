require "net/http"
require "uri"

module Google
  class Geocoder
    GOOGLE_GEOCODING_URL = "https://maps.googleapis.com/maps/api/geocode/json"

    def self.location_search(address)
      uri = URI.parse(GOOGLE_GEOCODING_URL)
      uri.query = URI.encode_www_form(build_params(address))
      request = Net::HTTP::Get.new(uri.request_uri)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      JSON.parse(response.body)["results"][0]["geometry"]["location"]
    end

    private
      def self.build_params(address)
        { address: address, key: Settings.google.api_key }
      end
  end
end
