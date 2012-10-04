# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[BiddingLog, CurrentBid].each do |table|
  [ 'Paladium 1', 'Paladium 2', 'Paladium 3', 'Paladium 4', 
    'Riverside 1', 'Riverside 2', 'Riverside 3', 'Riverside 4', 'Riverside 5', 'Riverside 6', 'Riverside 7'].each do |spot|
    table.create(
      :parking_spot => spot,
      :name => "",
      :email => "",
      :bid => 0,
      :max_bid => 0
    
    )
  end
end
