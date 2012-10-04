class CurrentBid < ActiveRecord::Base
  attr_accessible :bid, :email, :max_bid, :name, :parking_spot
  
  def self.all_spots
    ['Paladium 1', 'Paladium 2', 'Paladium 3', 'Paladium 4', 'Riverside 1', 'Riverside 2', 'Riverside 3', 'Riverside 4','Riverside 5', 'Riverside 6', 'Riverside 7']
  end
  
  after_update :update_bidding_log
  
  private
    def update_bidding_log
      @entry = BiddingLog.new(att self)
      @entry.save
    end
    
      private
  
    def att o
      { :parking_spot => o.parking_spot, 
        :name => o.name, 
        :email => o.email, 
        :bid => o.bid, 
        :max_bid => o.max_bid
      }  
    end 
  
end
