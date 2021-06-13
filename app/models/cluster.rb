class Cluster < ApplicationRecord
  belongs_to :location, optional: true
end
