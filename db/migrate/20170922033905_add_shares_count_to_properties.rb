class AddSharesCountToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :shares_count, :integer, default: 0
    add_column :properties, :visits_count, :integer, default: 0
  end
end
