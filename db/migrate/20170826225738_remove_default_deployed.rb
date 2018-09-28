class RemoveDefaultDeployed < ActiveRecord::Migration[5.1]
  def change
    change_column :knack_post, :deployed, :boolean
  end
end
