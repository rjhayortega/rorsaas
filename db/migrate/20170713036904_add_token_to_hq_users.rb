class AddTokenToHqUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :hq_users, :authentication_token, :string
  end
end
