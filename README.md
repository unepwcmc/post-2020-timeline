# Post 2020 Timeline

## Setup

- `bundle install`
- `yarn install`
- `bundle exec rake db:create`
- `bundle exec rake db:migrate`
- `bundle exec rake import:events['lib/data/seed/post-2020-timeline-2018-01-04.csv']`
- `rails s`

## Importing data

- Import event rake task
- `rake import:events['lib/data/seed/post-2020-timeline-2018-01-09.csv']`
- Check logs to see any errors
