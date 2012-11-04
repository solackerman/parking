class CurrentBidsController < ApplicationController
  # GET /current_bids
  # GET /current_bids.json
  def index
    @current_bids = CurrentBid.order('id ASC').all
    @bids = {'Paladium' => [], 'Riverside' => []}
    @current_bids.each do |row|
      @location = row[:parking_spot][0..-3]
      @bids[@location] = @bids[@location].push(row)
    end
    
    @over = CurrentBid.end_time.to_i < Time.new.to_i ? true : false
    if @over 
      flash[:notice] = "The auction has ended. Congratulations to all the winners!"
    end
    respond_to do |format|
      format.html
    end
  end

  # POST /current_bids
  # POST /current_bids.json
  def create
   
    @your_bid = CurrentBid.new(params[:current_bid])

    #time's up
    if CurrentBid.end_time.to_i < Time.new.to_i 
      flash[:info] = "The auction has ended."
    #check data for errors
    elsif !(@your_bid.parking_spot!="Your parking spot" and 
            @your_bid.name =~ /[A-Za-z-]+ [A-Za-z-]+/ and 
            @your_bid.email =~ /^[\w-.]+@ca\.ibm\.com$/ and 
            @your_bid.max_bid.is_a? Integer) 
      flash[:error] = "The data entered is invalid. Make sure to include your desired parking spot, first and last name, IBM email address, and bid."
    else           
      @current_bid = CurrentBid.find_by_parking_spot(@your_bid.parking_spot)
      @top_bidder = CurrentBid.new(att @current_bid)
      if @your_bid.max_bid <= @top_bidder.bid
        flash[:error] = "Your bid is not high enough. Please try again."
        
      elsif @your_bid.max_bid <= @top_bidder.max_bid
        @your_bid.bid = @top_bidder.bid + 1
        @current_bid.update_attributes(att @your_bid)
        
        if @your_bid.bid == @top_bidder.max_bid
          flash[:success] = "Congratulations! You are the highest bidder for #{@your_bid.parking_spot} with $#{@your_bid.bid}. You will automatically outbid others up to $#{@your_bid.max_bid}."
        else
          if @your_bid.bid == @your_bid.max_bid
            @top_bidder.bid = @your_bid.max_bid + 1
          else
            @top_bidder.bid = @your_bid.max_bid  
          end
          
          @current_bid.update_attributes(att @top_bidder)          
          flash[:warning] = "You were outbid for #{@your_bid.parking_spot}. Please try again."
        end
        
      elsif @your_bid.max_bid > @top_bidder.max_bid
        @your_bid.bid = @top_bidder.bid + 1
        @current_bid.update_attributes(att @your_bid)
        
        if @top_bidder.bid != @top_bidder.max_bid and @your_bid.bid < @top_bidder.max_bid
          @top_bidder.bid = @top_bidder.max_bid
          @current_bid.update_attributes(att @top_bidder)
          
          @your_bid.bid = @top_bidder.bid + 1
          @current_bid.update_attributes(att @your_bid)
        end
        
        flash[:success] = "Congratulations! You are the highest bidder for #{@your_bid.parking_spot} with $#{@your_bid.bid}. You will automatically outbid others up to $#{@your_bid.max_bid}."
      end  
    end
    
    respond_to do |format| 
      format.html { redirect_to current_bids_path } 
    end
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
