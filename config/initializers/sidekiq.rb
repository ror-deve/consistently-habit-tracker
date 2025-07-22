schedule_file = "config/schedule.yml"

if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq.schedule = YAML.load_file(schedule_file)
  Sidekiq::Scheduler.reload_schedule!
end
