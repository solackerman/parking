class CreateCurrentBids < ActiveRecord::Migration
  def change
    create_table :current_bids do |t|
      t.string :parking_spot
      t.string :name
      t.string :email
      t.integer :max_bid
      t.integer :bid

      t.timestamps
    end
  end
end
