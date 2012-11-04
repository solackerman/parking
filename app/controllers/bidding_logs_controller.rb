class BiddingLogsController < ApplicationController
  # GET /bidding_logs
  # GET /bidding_logs.json
  def index
    @bidding_logs = BiddingLog.find(:all, :order => "bid DESC")
    @bids = {}
    @bidding_logs.each do |row|
      @bids[row[:parking_spot]] = @bids[row[:parking_spot]] ? @bids[row[:parking_spot]].push(row) : [row]
    end
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
