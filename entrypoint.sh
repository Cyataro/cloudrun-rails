#!/bin/bash
set -e

RAILS_PORT=3000
RAILS_ENV=production
if [ -n "$PORT" ]; then
  RAILS_PORT=$PORT
fi

# migration
bin/rails db:migrate 

# assets precompile
bundle exec rake assets:precompile

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
# exec "$@"
rails server -p $RAILS_PORT -b 0.0.0.0
