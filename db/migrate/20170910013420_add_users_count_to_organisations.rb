class AddUsersCountToOrganisations < ActiveRecord::Migration[5.1]
  def change
    add_column :organisations, :users_count, :integer, default: 0
  end
end
