class CreatePromotionPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :promotion_posts do |t|
      t.text :description
      t.string :post_url
      t.string :utc_offset
      t.string :image
      t.string :subimage1
      t.string :subimage2
      t.string :subimage3
      t.belongs_to :author

      t.timestamps
    end
  end
end
