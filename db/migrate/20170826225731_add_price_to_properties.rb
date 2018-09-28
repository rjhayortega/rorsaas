class AddPriceToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :price, :float
  end
end
