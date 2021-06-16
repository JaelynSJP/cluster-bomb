class LocationsController < ApplicationController
  def index
    @active_clusters = Cluster.where.not(location_id: nil).where(is_active: true)
    @markers = @active_clusters.map do |cluster|
      unless cluster.location.latitude.nil? and cluster.location.longitude.nil?
        {
          name: cluster.name,
          num_of_cases: cluster.num_of_cases,
          lat: cluster.location.latitude,
          lng: cluster.location.longitude,
          info_window: render_to_string(partial: "info_window", locals: { cluster: cluster }),
          image_url: helpers.asset_url('bomb.png')
        }
      end
    end
    @inactive_clusters = Cluster.where.not(location_id: nil).where(is_active: false)
  end
end
