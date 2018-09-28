class AddBedsToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :beds, :integer, default: 0
    add_column :properties, :bath, :integer, default: 0
    add_column :properties, :parking, :integer, default: 0
  end
end
