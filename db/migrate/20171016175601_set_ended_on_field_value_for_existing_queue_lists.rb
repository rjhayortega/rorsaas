class SetEndedOnFieldValueForExistingQueueLists < ActiveRecord::Migration[5.1]
  def change
    QueueList.all.each do |queue_list|
      queue_list.update_column :ended_on, queue_list.started_on + 1.day
    end
  end
end
