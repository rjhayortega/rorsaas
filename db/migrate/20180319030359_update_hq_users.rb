class UpdateHqUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column(:hq_users, :provider, :string, limit: 50, null: false, default: '')
    add_column(:hq_users, :uid, :string, limit: 500, null: false, default: '')
  
  end
end
