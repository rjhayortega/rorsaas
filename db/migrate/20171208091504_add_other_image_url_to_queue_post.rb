class AddOtherImageUrlToQueuePost < ActiveRecord::Migration[5.1]
  def change
    add_column :queue_posts, :other_image_url, :string
  end
end
