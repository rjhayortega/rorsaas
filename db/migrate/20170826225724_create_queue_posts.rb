class CreateQueuePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :queue_posts do |t|
      t.text :description
      t.string :post_url
      t.string :utc_offset
      t.string :queue_post
      t.string :image
      t.string :subimage1
      t.string :subimage2
      t.string :subimage3
      t.belongs_to :queue_list, foreign_key: true

      t.timestamps
    end
  end
end
