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
    @current_bid = CurrentBid.new
    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @current_bids }
    end
  end

  # GET /current_bids/1
  # GET /current_bids/1.json
  def show
    @current_bid = CurrentBid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @current_bid }
    end
  end

  # GET /current_bids/new
  # GET /current_bids/new.json
  def new
    @current_bid = CurrentBid.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @current_bid }
    end
  end

  # GET /current_bids/1/edit
  def edit
    @current_bid = CurrentBid.find(params[:id])
  end

  # POST /current_bids
  # POST /current_bids.json
  def create
    #check data for errors    
    @your_bid = CurrentBid.new(params[:current_bid])
    @current_bid = CurrentBid.find_by_parking_spot(@your_bid.parking_spot)
    @top_bidder = CurrentBid.new(att @current_bid)

    if !(@your_bid.name.is_a? String and @your_bid.email.is_a? String and @your_bid.max_bid.is_a? Integer) 
      flash[:warning] = 'The data entered is invalid. Please try again.'
    elsif @your_bid.max_bid <= @top_bidder.bid
      flash[:warning] = "Your bid is not high enough. Please try again."
    elsif @your_bid.max_bid <= @top_bidder.max_bid
      @your_bid.bid = @top_bidder.bid + 1
      @current_bid.update_attributes(att @your_bid)
      
      @top_bidder.bid = @your_bid.max_bid
      @current_bid.update_attributes(att @top_bidder)
      
      flash[:warning] = "You were outbid for #{@your_bid.parking_spot}. Please try again."
    elsif @your_bid.max_bid > @top_bidder.max_bid
      @your_bid.bid = @top_bidder.bid + 1
      @current_bid.update_attributes(att @your_bid)
      if @top_bidder.bid != @top_bidder.max_bid
        @top_bidder.bid = @top_bidder.max_bid
        @current_bid.update_attributes(att @top_bidder)
        
        @your_bid.bid = @top_bidder.bid + 1
        @current_bid.update_attributes(att @your_bid)
      end
      flash[:notice] = "Congratulations! You are the highest bidder for #{@your_bid.parking_spot}."
    end
    
    
    respond_to do |format| 
      format.html { redirect_to current_bids_path } 
    end
    # respond_to do |format|
      # if @current_bid.save
        # format.html { redirect_to current_bids_path, notice: 'Current bid was successfully created.' }
      # else
        # format.html { redirect_to current_bids_path, error: 'Unable to process request.' }
      # end
    # end
  end

  # PUT /current_bids/1
  # PUT /current_bids/1.json
  def update
    @current_bid = CurrentBid.find(params[:id])

    respond_to do |format|
      if @current_bid.update_attributes(params[:current_bid])
        format.html { redirect_to @current_bid, notice: 'Current bid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @current_bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_bids/1
  # DELETE /current_bids/1.json
  def destroy
    @current_bid = CurrentBid.find(params[:id])
    @current_bid.destroy

    respond_to do |format|
      format.html { redirect_to current_bids_url }
      format.json { head :no_content }
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
