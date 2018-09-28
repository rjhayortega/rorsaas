class CreateProfileQueueList < ActiveRecord::Migration[5.1]
  def change
    create_table :profile_queue_lists do |t|
      t.belongs_to :profile
      t.belongs_to :queue_list, foreign_key: true
    end
  end
end
