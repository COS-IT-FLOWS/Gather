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

command -v git     >/dev/null 2>&1 || { error "git is required but not installed";     exit 1; }
command -v flutter >/dev/null 2>&1 || { error "flutter is required but not installed"; exit 1; }

# --- Guard: must be on a deploy/google-play* branch -----------------------

BRANCH=$(git rev-parse --abbrev-ref HEAD)

case "$BRANCH" in
  deploy/google-play-internal)
    TRACK="internal"
    ;;
  deploy/google-play-production)
    TRACK="production"
    ;;
  deploy/google-play)
    TRACK="production"
    ;;
  *)
    error "Not on a deploy/google-play* branch (current: $BRANCH)"
    exit 1
    ;;
esac

# --- Extract app name & version from pubspec.yaml -------------------------

APP_NAME=$(grep '^name: ' pubspec.yaml | sed 's/name: //')
VERSION=$(grep '^version: ' pubspec.yaml | sed 's/version: //')

VERSION_NAME="${VERSION%+*}"   # 0.0.1
VERSION_CODE="${VERSION#*+}"   # 4

# --- Build -----------------------------------------------------------------

info "Branch:   $BRANCH"
info "Track:    $TRACK"
info "App:      $APP_NAME"
info "Version:  $VERSION"

flutter clean
flutter pub get
flutter build appbundle --release

# --- Output ----------------------------------------------------------------

OUTPUT_DIR="releases/$TRACK"
mkdir -p "$OUTPUT_DIR"

OUTPUT_FILE="$OUTPUT_DIR/${APP_NAME}-${VERSION_NAME}_${VERSION_CODE}.aab"
SOURCE="build/app/outputs/bundle/release/app-release.aab"

cp "$SOURCE" "$OUTPUT_FILE"

# --- Summary ---------------------------------------------------------------

SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)

echo ""
info "═══════════════════════════════════════"
info "  Track:     $TRACK"
info "  Version:   $VERSION"
info "  Output:    $OUTPUT_FILE"
info "  Size:      $SIZE"
info "═══════════════════════════════════════"
echo ""
info "Done."
