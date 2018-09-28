# job_type :runner,  "cd :path && bundle exec rails runner -e :environment ':task' :output"

every 5.minutes do
  # command "/usr/bin/some_great_command"
  runner "TaskSchedulerJob.perform_now"
  # rake "mirror_tasks"
end