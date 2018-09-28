class AddOtherImageUrlToKnackPost < ActiveRecord::Migration[5.1]
  def change
    add_column :knack_post, :other_image_url, :string
  end
end
