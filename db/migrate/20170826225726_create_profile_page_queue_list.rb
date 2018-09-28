class CreateProfilePageQueueList < ActiveRecord::Migration[5.1]
  def change
    create_table :profile_page_queue_lists do |t|
      t.belongs_to :profile_page
      t.belongs_to :queue_list, foreign_key: true
    end
  end
end
