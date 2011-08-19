# What is it
- Small app to download pivotal tracker stories to a mysql

# How to set it up
    git clone git://github.com/pgericson/pivotal-tracker-db-access.git
    cd pivotal-tracker-db-access
    rake db:setup
    vi config/pivotal_tracker.yml

input the following line in the Yaml file
    token: your_pivotal_tracker_token_here
save it
    cp config/database.yml.example config/database.yml
    vi config/database.yml
Change what needs to be changed
    rake pt:update
**DONE**
