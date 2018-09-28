class AddEndedOnFieldToQueueLists < ActiveRecord::Migration[5.1]
  def change
  	add_column :queue_lists, :ended_on, :date
  end
end
