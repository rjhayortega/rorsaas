class AddDeployedToKnackPost < ActiveRecord::Migration[5.1]
  def change
    add_column :knack_post, :deployed, :boolean
    add_column :knack_post, :post_tasks_count, :integer, default: 0
    Post.find_each { |post| Post.reset_counters(post.id, :post_tasks) }
  end
end
