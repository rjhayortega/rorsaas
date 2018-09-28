class AddScheduledAtToPromotionPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :promotion_posts, :scheduled_at, :datetime
  end
end
