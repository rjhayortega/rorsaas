class AddIsRentToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :is_rent, :boolean, default: false
  end
end
