class TaskRunnerJob < ApplicationJob
  # include Sidekiq::Worker
  # sidekiq_options :queue => :crawler, :retry => true
  # queue_as :default
  
  def perform task_id
    task = PostTask.find_by id: task_id
    unless task.blank? || task.deployed
      task.update deployed: true
      task.run
    end
  end
  
end
