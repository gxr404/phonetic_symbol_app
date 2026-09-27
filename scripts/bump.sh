#!/usr/bin/env bash

set -e

# ============================================================
# Flutter Version Bump Script
#
# Usage:
#   ./scripts/bump.sh
#
# Version:
#   1.2.3+16
#
# major/minor/patch/breaking:
#   - dart pub bump xxx
#   - build number +1
#   - commit
#   - create git tag: v1.2.4
#
# build:
#   - build number +1
#   - commit
#   - NO git tag
# ============================================================


# ------------------------------------------------------------
# Helpers
# ------------------------------------------------------------

error() {
  echo "Error: $1" >&2
  exit 1
}


# ------------------------------------------------------------
# Check Git repository
# ------------------------------------------------------------

if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
  error "Not inside a Git repository."
fi

PROJECT_ROOT="$(git rev-parse --show-toplevel)"

cd "$PROJECT_ROOT"


# ------------------------------------------------------------
# Check required commands/files
# ------------------------------------------------------------

command -v git >/dev/null 2>&1 \
  || error "git command not found."

command -v dart >/dev/null 2>&1 \
  || error "dart command not found."

[ -f "pubspec.yaml" ] \
  || error "pubspec.yaml not found."


# ------------------------------------------------------------
# Check Git working tree
# ------------------------------------------------------------

if ! git diff --quiet || ! git diff --cached --quiet; then
  error "Git working tree is not clean.

Please commit or stash your changes first."
fi


# ------------------------------------------------------------
# Read current version
# ------------------------------------------------------------

current_version="$(
  sed -n 's/^version:[[:space:]]*//p' pubspec.yaml | head -n 1
)"

[ -n "$current_version" ] \
  || error "Could not read version from pubspec.yaml."


# ------------------------------------------------------------
# Parse version
#
# Example:
#
#   1.2.3+16
#
# app_version  = 1.2.3
# build_number = 16
# ------------------------------------------------------------

if [[ "$current_version" == *"+"* ]]; then
  app_version="${current_version%%+*}"
  build_number="${current_version##*+}"
else
  app_version="$current_version"
  build_number="0"
fi


# ------------------------------------------------------------
# Validate build number
# ------------------------------------------------------------

if ! [[ "$build_number" =~ ^[0-9]+$ ]]; then
  error "Invalid build number: $build_number"
fi


# ------------------------------------------------------------
# Select bump type
# ------------------------------------------------------------

echo
echo "========================================"
echo " Flutter Version Bump"
echo "========================================"
echo
echo "Current version: $current_version"
echo
echo "Select version bump:"
echo
echo "  1) major"
echo "  2) minor"
echo "  3) patch"
echo "  4) breaking"
echo "  5) build"
echo "  q) quit"
echo

read -r -p "Choose [1-5/q]: " choice


case "$choice" in
  1)
    bump_type="major"
    ;;
  2)
    bump_type="minor"
    ;;
  3)
    bump_type="patch"
    ;;
  4)
    bump_type="breaking"
    ;;
  5)
    bump_type="build"
    ;;
  q|Q)
    echo "Cancelled."
    exit 0
    ;;
  *)
    error "Invalid choice."
    ;;
esac


# ============================================================
# VERSION BUMP
# ============================================================

if [[ "$bump_type" != "build" ]]; then

  # ----------------------------------------------------------
  # Run Dart version bump
  # ----------------------------------------------------------

  echo
  echo "Running:"
  echo "  dart pub bump $bump_type"
  echo

  dart pub bump "$bump_type"


  # ----------------------------------------------------------
  # Read version after Dart bump
  # ----------------------------------------------------------

  bumped_version="$(
    sed -n 's/^version:[[:space:]]*//p' pubspec.yaml | head -n 1
  )"

  [ -n "$bumped_version" ] \
    || error "Could not read version after dart pub bump."


  # ----------------------------------------------------------
  # Parse bumped version
  # ----------------------------------------------------------

  if [[ "$bumped_version" == *"+"* ]]; then
    new_app_version="${bumped_version%%+*}"
    new_build_number="${bumped_version##*+}"
  else
    new_app_version="$bumped_version"
    new_build_number="0"
  fi


else

  # ==========================================================
  # BUILD ONLY
  # ==========================================================

  new_app_version="$app_version"
  new_build_number="$build_number"

fi


# ------------------------------------------------------------
# Increment build number
# ------------------------------------------------------------

new_build_number=$((new_build_number + 1))

new_version="${new_app_version}+${new_build_number}"


# ------------------------------------------------------------
# Update pubspec.yaml
#
# macOS BSD sed:
#
#   sed -i ''
# ------------------------------------------------------------

sed -i '' \
  "s/^version:.*/version: $new_version/" \
  pubspec.yaml


# ------------------------------------------------------------
# Verify version
# ------------------------------------------------------------

final_version="$(
  sed -n 's/^version:[[:space:]]*//p' pubspec.yaml | head -n 1
)"

[ "$final_version" = "$new_version" ] \
  || error "Failed to update pubspec.yaml."


# ============================================================
# Git metadata
# ============================================================

if [[ "$bump_type" == "build" ]]; then

  # ----------------------------------------------------------
  # Build-only bump
  # ----------------------------------------------------------

  commit_message="chore: bump build to $final_version"

  tag=""

else

  # ----------------------------------------------------------
  # Version bump
  # ----------------------------------------------------------

  commit_message="chore: bump version to $final_version"

  tag="v${new_app_version}"

fi


# ------------------------------------------------------------
# Check tag
# ------------------------------------------------------------

if [[ -n "$tag" ]]; then

  if git rev-parse "$tag" >/dev/null 2>&1; then
    error "Git tag already exists: $tag"
  fi

fi


# ============================================================
# Show summary
# ============================================================

echo
echo "========================================"
echo " Version Bump Summary"
echo "========================================"
echo
echo " Old version : $current_version"
echo " New version : $final_version"
echo
echo " Type        : $bump_type"
echo " Commit      : $commit_message"

if [[ -n "$tag" ]]; then
  echo " Git tag     : $tag"
else
  echo " Git tag     : none"
fi

echo
echo "========================================"
echo


# ------------------------------------------------------------
# Confirm commit
# ------------------------------------------------------------

read -r -p "Create commit${tag:+ and tag}? [y/N]: " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then

  echo
  echo "Cancelled."
  echo
  echo "pubspec.yaml has been changed to:"
  echo "  $final_version"
  echo
  echo "Review the change with:"
  echo "  git diff"
  echo
  echo "If you want to discard it:"
  echo "  git restore pubspec.yaml"

  exit 0

fi


# ============================================================
# Git add
# ============================================================

git add pubspec.yaml


# ============================================================
# Git commit
# ============================================================

git commit -m "$commit_message"


# ============================================================
# Git tag
# ============================================================

if [[ -n "$tag" ]]; then

  git tag "$tag"

fi


# ============================================================
# Completed
# ============================================================

echo
echo "========================================"
echo " Completed"
echo "========================================"
echo
echo "Version : $final_version"
echo "Commit  : $commit_message"

if [[ -n "$tag" ]]; then
  echo "Tag     : $tag"
else
  echo "Tag     : none"
fi

echo


# ============================================================
# Confirm push
# ============================================================

read -r -p "Push to remote? [y/N]: " push_confirm

if [[ ! "$push_confirm" =~ ^[Yy]$ ]]; then

  echo
  echo "Push skipped."
  echo

  if [[ -n "$tag" ]]; then
    echo "To push later:"
    echo
    echo "  git push"
    echo "  git push origin $tag"
  else
    echo "To push later:"
    echo
    echo "  git push"
  fi

  exit 0

fi


# ============================================================
# Push commit
# ============================================================

echo
echo "Pushing commit..."

git push


# ============================================================
# Push tag
# ============================================================

if [[ -n "$tag" ]]; then

  echo
  echo "Pushing tag $tag..."

  git push origin "$tag"

fi


# ============================================================
# Done
# ============================================================

echo
echo "========================================"
echo " Push completed"
echo "========================================"
echo
echo "Version : $final_version"

if [[ -n "$tag" ]]; then
  echo "Tag     : $tag"
fi

echo