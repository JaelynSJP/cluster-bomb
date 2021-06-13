class ChangeLocationIdNullInCluster < ActiveRecord::Migration[6.1]
  def change
    change_column_null :clusters, :location_id, true
  end
end
