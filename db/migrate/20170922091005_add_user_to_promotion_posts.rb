class AddUserToPromotionPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :promotion_posts, :user
  end
end
