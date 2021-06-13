class CreateClusters < ActiveRecord::Migration[6.1]
  def change
    create_table :clusters do |t|
      t.integer :num_of_cases
      t.boolean :is_active
      t.string :name
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
