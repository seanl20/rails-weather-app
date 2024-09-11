# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @data, @icon_url = Queries::GetWeather.new.call
  end
end