class LocationsController < ApplicationController
  def index
    @locations = []
    clusters = Cluster.where.not(location_id: nil).where(is_active: true)
    clusters.each { |cluster| @locations << cluster.location }

    @markers = @locations.map do |location|
      unless location.latitude.nil? and location.longitude.nil?
        {
          lat: location.latitude,
          lng: location.longitude,
          info_window: render_to_string(partial: "info_window", locals: { location: location }),
          image_url: helpers.asset_url('bomb.png')
        }
      end
    end

    @inactive_clusters = Cluster.where.not(location_id: nil).where(is_active: false)
  end
end
