# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @data = Queries::GetWeather.new.call(latitude: "-27.4705", longitude: "153.0260")
  end
end