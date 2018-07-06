class CitiesController < ApplicationController
  def index
    @cities = City.all.select { |city| city.jobs.any? }
  end
end
