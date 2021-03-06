class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :postal_code
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
