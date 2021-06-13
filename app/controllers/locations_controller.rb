class LocationsController < ApplicationController
  def index
    @locations = Location.all
    raise

    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude
      }
    end
  end
end
