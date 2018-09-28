class CreatePropertyImages < ActiveRecord::Migration[5.1]
  def change
    create_table :property_images do |t|
      t.string :file
      t.belongs_to :property, foreign_key: true

      t.timestamps
    end
  end
end
