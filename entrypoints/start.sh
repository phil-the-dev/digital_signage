#!/bin/sh

if [ -f .env ]
then
# Debian / mac agnostic script which will load .env file into environment, ignoring comments and preserving spaces. 
  set -o allexport
  eval $(grep -v '^#' .env | sed 's/^/export /')
  set +o allexport
else
  echo "No .env file supplied, falling back to parameter store values."
fi

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# if [ ${SERVICE} == "api" ]; then
#   if [[ ${RAILS_ENV} == "development" && ${IDE_DEBUG} == "true" ]]; then
#     bundle exec rdebug-ide --debug --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- bin/bundle exec rails s puma -p ${APP_PORT:-3000} -e ${RAILS_ENV}
#   else
#     echo 'Starting digital_signage..'
#     bundle exec rails s puma -t 5:${RAILS_MAX_THREADS:-5} -p ${APP_PORT:-3000} -e ${RAILS_ENV}
#   fi
# fi

bundle exec rails s -b 0.0.0.0