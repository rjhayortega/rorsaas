class AddQueuePostsCountToQueueLists < ActiveRecord::Migration[5.1]
  def change
    add_column :queue_lists, :queue_posts_count, :integer, default: 0
  end
end
