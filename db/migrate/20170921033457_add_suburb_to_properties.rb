class AddSuburbToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :address2, :string
    add_column :properties, :country, :string
  end
end
