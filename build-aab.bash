#!/bin/bash

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC}  $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# --- Guard: required tools ------------------------------------------------

command -v git        >/dev/null 2>&1 || { error "git is required but not installed";     exit 1; }
command -v bundle     >/dev/null 2>&1 || { error "bundler is required but not installed";  exit 1; }

# --- Guard: must be on a deploy/google-play* branch -----------------------

BRANCH=$(git rev-parse --abbrev-ref HEAD)

case "$BRANCH" in
  deploy/google-play-internal)
    TRACK="internal"
    ;;
  deploy/google-play-production|deploy/google-play)
    TRACK="production"
    ;;
  *)
    error "Not on a deploy/google-play* branch (current: $BRANCH)"
    exit 1
    ;;
esac

# --- Run fastlane ---------------------------------------------------------

info "Branch:  $BRANCH"
info "Track:   $TRACK"
info ""

bundle exec fastlane android "$TRACK"
