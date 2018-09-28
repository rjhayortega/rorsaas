class AddIdBeforeSplittingToKnackPost < ActiveRecord::Migration[5.1]
  def change
    add_column :knack_post, :id_before_splitting, :integer, limit: 8
  end
end
