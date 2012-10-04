class BiddingLog < ActiveRecord::Base
  attr_accessible :parking_spot, :name, :email, :max_bid, :bid 
end
