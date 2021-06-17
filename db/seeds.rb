require 'csv'

puts 'Cleaning  Location database...'
Cluster.destroy_all
puts 'Cleaning  Cluster database...'
Location.destroy_all

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'lib/seeds/clusterList.csv'

CSV.foreach(filepath, csv_options) do |row|
  cluster = Cluster.new(name: row['cluster_name'], num_of_cases: row['num_of_cases'], is_active: row['is_active'], location_id: "")
  unless row['address'].nil?
    location = Location.create(name: row['location_name'], postal_code: row['postal_code'], address:row['address'])
    cluster.location = location
  end 
  if cluster.save!
    puts "#{cluster.name} is saved"
  end

  # location = Location.create(name: row['location_name'], postal_code: row['postal_code'], address:row['address'])
  # cluster = Cluster.new(name: row['cluster_name'], num_of_cases: row['num_of_cases'], is_active: row['is_active'])
  # cluster.location = location
  # if cluster.save!
  #   puts "#{cluster.name} is saved, #{cluster.location.address} is saved"
  # end
  # puts "#{row['cluster_name']}, #{row['num_of_cases']} , #{row['is_active']},#{row['location_name']},#{row['postal_code']},#{row['address']}"
end

