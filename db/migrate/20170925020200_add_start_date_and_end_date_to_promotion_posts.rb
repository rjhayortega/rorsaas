class AddStartDateAndEndDateToPromotionPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :promotion_posts, :start_date, :date
    add_column :promotion_posts, :end_date, :date
    remove_column :promotion_posts, :scheduled_at, :datetime
  end
end
