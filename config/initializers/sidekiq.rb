Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../scheduler.yml', File.dirname(__FILE__)))
    Sidekiq::Scheduler.reload_schedule!
  end
end
