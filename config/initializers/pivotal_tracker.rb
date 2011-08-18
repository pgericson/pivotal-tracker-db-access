PT_TOKEN = YAML.load_file("#{Rails.root}/config/pivotal_tracker.yml")["token"]
PivotalTracker::Client.token = PT_TOKEN
