class AddUsersCountToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :users_count, :integer, default: 0
  end
end
