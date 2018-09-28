class CreatePostTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :post_tasks do |t|
      t.belongs_to :post
      t.belongs_to :profilable, polymorphic: true
      t.text :result

      t.timestamps
    end
  end
end
