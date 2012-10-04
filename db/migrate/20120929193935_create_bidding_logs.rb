class CreateBiddingLogs < ActiveRecord::Migration
  def change
    create_table :bidding_logs do |t|
      t.string :location
      t.integer :spot
      t.string :name
      t.string :email
      t.integer :max_bid
      t.timestamp :placed_at

      t.timestamps
    end
  end
end
