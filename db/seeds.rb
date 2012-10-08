# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[BiddingLog, CurrentBid].each do |table|
  CurrentBid.auction_spots.each do |spot|
    table.create(
      :parking_spot => spot,
      :name => "",
      :email => "",
      :bid => 0,
      :max_bid => 0
    
    )
  end
end

[BiddingLog, CurrentBid].each do |table|
  CurrentBid.raffle_spots.each do |spot|
    table.create(
      :parking_spot => spot,
      :name => "to be",
      :email => "raffled off",
      :bid => 0,
      :max_bid => 0
    
    )
  end
end
