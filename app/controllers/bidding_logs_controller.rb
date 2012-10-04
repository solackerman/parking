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
      format.json { render json: @bidding_logs }
    end
  end

  # GET /bidding_logs/1
  # GET /bidding_logs/1.json
  # def show
    # @bidding_log = BiddingLog.find(params[:id])
# 
    # respond_to do |format|
      # format.html # show.html.erb
      # format.json { render json: @bidding_log }
    # end
  # end
# 
  # # GET /bidding_logs/new
  # # GET /bidding_logs/new.json
  # def new
    # @bidding_log = BiddingLog.new
# 
    # respond_to do |format|
      # format.html # new.html.erb
      # format.json { render json: @bidding_log }
    # end
  # end
# 
  # # GET /bidding_logs/1/edit
  # def edit
    # @bidding_log = BiddingLog.find(params[:id])
  # end
# 
  # # POST /bidding_logs
  # # POST /bidding_logs.json
  # def create
    # @bidding_log = BiddingLog.new(params[:bidding_log])
# 
    # respond_to do |format|
      # if @bidding_log.save
        # format.html { redirect_to @bidding_log, notice: 'Bidding log was successfully created.' }
        # format.json { render json: @bidding_log, status: :created, location: @bidding_log }
      # else
        # format.html { render action: "new" }
        # format.json { render json: @bidding_log.errors, status: :unprocessable_entity }
      # end
    # end
  # end
# 
  # # PUT /bidding_logs/1
  # # PUT /bidding_logs/1.json
  # def update
    # @bidding_log = BiddingLog.find(params[:id])
# 
    # respond_to do |format|
      # if @bidding_log.update_attributes(params[:bidding_log])
        # format.html { redirect_to @bidding_log, notice: 'Bidding log was successfully updated.' }
        # format.json { head :no_content }
      # else
        # format.html { render action: "edit" }
        # format.json { render json: @bidding_log.errors, status: :unprocessable_entity }
      # end
    # end
  # end
# 
  # # DELETE /bidding_logs/1
  # # DELETE /bidding_logs/1.json
  # def destroy
    # @bidding_log = BiddingLog.find(params[:id])
    # @bidding_log.destroy
# 
    # respond_to do |format|
      # format.html { redirect_to bidding_logs_url }
      # format.json { head :no_content }
    # end
  # end
end
