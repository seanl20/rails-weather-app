# frozen_string_literal: true

module Queries
  class GetWeather
    def call(latitude:, longitude:, units: "metric")
      # url = "lat=&lon=&appid=#{Constants::API_KEY}"

      uri = build_uri(longitude:, latitude:, units:)

      response_json = json_parse_response(uri:)

      icon_url = build_icon_url(response_json)

      build_weather_struct(response_json:, icon_url:)
    end

    def build_uri(longitude:, latitude:, units:)
      uri = URI(Constants::OPEN_WEATHER_URL)

      params = {
        lat: latitude,
        lon: longitude,
        appid: Constants::API_KEY,
        units:
      }

      uri.query = URI.encode_www_form(params)

      return uri
    end

    def json_parse_response(uri:)
      response = Net::HTTP.get_response(uri)
      response_json = JSON.parse(response.body)
    end

    def build_icon_url(response)
      icon_url = "https://openweathermap.org/img/wn/#{response["weather"].first["icon"]}@2x.png"
    end

    def build_weather_struct(response_json:, icon_url:)
      Structs::Weather.new(
        icon_url:,
        main: response_json["weather"].first["main"],
        description: response_json["weather"].first["description"],
        temp: response_json["main"]["temp"]
      )
    end
  end
end
