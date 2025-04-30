#!/bin/bash

if [ "$WORKER_MODE" != "worker" ]; then
  echo "Running migrations..."
  medusa migrations run
else
  echo "Skipping migrations because WORKER_MODE=worker"
fi

exec "$@"
