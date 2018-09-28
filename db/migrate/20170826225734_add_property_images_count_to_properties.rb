class AddPropertyImagesCountToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :property_images_count, :integer
  end
end
