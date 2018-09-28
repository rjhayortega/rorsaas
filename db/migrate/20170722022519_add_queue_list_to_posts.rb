class AddQueueListToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :knack_post, :queue_list, foreign_key: true
  end
end
