class AddUtcOffsetToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :hq_users, :timezone, :string
    add_column :knack_users, :timezone, :string
  end
end
