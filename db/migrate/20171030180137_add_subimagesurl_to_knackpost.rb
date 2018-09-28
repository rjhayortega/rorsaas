class AddSubimagesurlToKnackpost < ActiveRecord::Migration[5.1]
  def change
  	add_column :knack_post, :sub_img1, :string
  	add_column :knack_post, :sub_img2, :string
  	add_column :knack_post, :sub_img3, :string

  end
end
