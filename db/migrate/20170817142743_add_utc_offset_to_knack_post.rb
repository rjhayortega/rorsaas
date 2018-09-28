class AddUtcOffsetToKnackPost < ActiveRecord::Migration[5.1]
  def change
    add_column :knack_post, :utc_offset, :string
    add_column :knack_post, :created_at, :datetime
  end
end
