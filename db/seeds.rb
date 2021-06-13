# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

puts 'Cleaning  Location database...'
Cluster.destroy_all
puts 'Cleaning  Cluster database...'
Location.destroy_all

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'lib/seeds/clusterList.csv'

CSV.foreach(filepath, csv_options) do |row|
  cluster = Cluster.new(name: row['cluster_name'], num_of_cases: row['num_of_cases'], is_active: row['is_active'])
  if row['address'].nil? == false
    location = Location.create(name: row['location_name'], postal_code: row['postal_code'], address:row['address'])
  else 
    location = NULL
  end 
  cluster.location = location
  if cluster.save!
    puts "#{cluster.name} is saved, #{cluster.location.address} is saved"
  end
  # location = Location.create(name: row['location_name'], postal_code: row['postal_code'], address:row['address'])
  # cluster = Cluster.new(name: row['cluster_name'], num_of_cases: row['num_of_cases'], is_active: row['is_active'])
  # cluster.location = location
  # if cluster.save!
  #   puts "#{cluster.name} is saved, #{cluster.location.address} is saved"
  # end
  # puts "#{row['cluster_name']}, #{row['num_of_cases']} , #{row['is_active']},#{row['location_name']},#{row['postal_code']},#{row['address']}"
end

