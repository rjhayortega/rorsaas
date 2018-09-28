class AddImagesToKnackPost < ActiveRecord::Migration[5.1]
  def change
    add_column :knack_post, :image, :string
    add_column :knack_post, :subimage1, :string
    add_column :knack_post, :subimage2, :string
    add_column :knack_post, :subimage3, :string
  end
end
