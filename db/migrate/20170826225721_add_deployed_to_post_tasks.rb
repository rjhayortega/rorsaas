class AddDeployedToPostTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :post_tasks, :deployed, :boolean, default: false
  end
end
