#!/bin/bash
# Generate appropriate research repository name from topic

set -e

TOPIC="$1"

if [ -z "$TOPIC" ]; then
  echo "Usage: $0 <topic>"
  echo "Example: $0 'lmcache'"
  echo "Example: $0 'llm cache'"
  exit 1
fi

# Normalize: lowercase, replace spaces with hyphens, remove special chars
NORMALIZED=$(echo "$TOPIC" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')

# Add research- prefix
REPO_NAME="research-${NORMALIZED}"

echo "$REPO_NAME"
