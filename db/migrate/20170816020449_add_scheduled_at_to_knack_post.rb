class AddScheduledAtToKnackPost < ActiveRecord::Migration[5.1]
  def change
    add_column :knack_post, :scheduled_at, :datetime
  end
end
