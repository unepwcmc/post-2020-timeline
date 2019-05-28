# Post 2020 Timeline

## Setup

- `bundle install`
- `yarn install`
- `bundle exec rake db:create`
- `bundle exec rake db:migrate`
- Import data using command below
- `rails s`

## Importing data

- Import event rake task
- `rake import:events['lib/data/seed/post-2020-timeline-2019-05-28.csv']`
- Check logs to see any errors
