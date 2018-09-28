class AddDefaultValueToDeployed < ActiveRecord::Migration[5.1]
  def up
    change_column :knack_post, :deployed, :boolean, default: false
    Post.update_all deployed: false
    Post.where("scheduled_at < ?", Time.current).update_all deployed: true
  end

  def down
    change_column :knack_post, :deployed, :boolean
  end
end
