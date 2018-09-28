class AddMaximumUsersCountToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :maximum_users_count, :integer, default: 10000
  end
end
