class CreateQueueLists < ActiveRecord::Migration[5.1]
  def change
    create_table :queue_lists do |t|
      t.string :name
      t.string :activity
      t.string :image
      t.date :started_on
      t.belongs_to :user

      t.timestamps
    end
  end
end
