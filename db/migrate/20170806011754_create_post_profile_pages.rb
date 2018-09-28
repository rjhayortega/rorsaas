class CreatePostProfilePages < ActiveRecord::Migration[5.1]
  def change
    create_table :post_profile_pages do |t|
      t.belongs_to :post
      t.belongs_to :knack_pages

      t.timestamps
    end
  end
end
