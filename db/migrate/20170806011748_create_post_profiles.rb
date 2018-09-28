class CreatePostProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :post_profiles do |t|
      t.belongs_to :post
      t.belongs_to :knack_profiles

      t.timestamps
    end
  end
end
