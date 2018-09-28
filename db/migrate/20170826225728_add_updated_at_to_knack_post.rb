class AddUpdatedAtToKnackPost < ActiveRecord::Migration[5.1]
  def change
    add_column :knack_post, :updated_at, :datetime
  end
end
