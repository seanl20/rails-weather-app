module Queries
  class GetWeather
    require 'net/http'

    def call
      url = "https://api.openweathermap.org/data/2.5/weather?lat=-27.4705&lon=153.0260&appid=#{Constants::API_KEY}"

      uri = URI(url)
      res = Net::HTTP.get_response(uri)
      # puts res.body if res.is_a?(Net::HTTPSuccess)
      response_json = JSON.parse(res.body)
      icon_url = "https://openweathermap.org/img/wn/#{response_json["weather"].first["icon"]}@2x.png"
      
      return response_json, icon_url
    end
  end
end
