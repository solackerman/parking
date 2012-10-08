class CurrentBid < ActiveRecord::Base
  attr_accessible :bid, :email, :max_bid, :name, :parking_spot
  
  def self.all_spots
    ['Paladium 1', 'Paladium 2', 'Paladium 3', 'Paladium 4', 'Riverside 1', 'Riverside 2', 'Riverside 3', 'Riverside 4','Riverside 5', 'Riverside 6', 'Riverside 7']
  end
  
  def self.raffle_spots
    ["Paladium 3", "Paladium 4", "Riverside 5", "Riverside 6", "Riverside 7"]
  end
  
  def self.auction_spots
    ['Paladium 1', 'Paladium 2', 'Riverside 1', 'Riverside 2', 'Riverside 3', 'Riverside 4']
  end
  
  def self.end_time
    Time.new(2012, "oct", 31, 15, 0, 0)
  end
  
  after_update :update_bidding_log
  
  private
    def update_bidding_log
      @entry = BiddingLog.new({ :parking_spot => self.parking_spot, 
        :name => self.name, 
        :email => self.email, 
        :bid => self.bid, 
        :max_bid => self.max_bid
      })
      @entry.save
    end
  
end
