#!/bin/bash

TARGET="$HOME/.config/nvim"
SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
  echo "backing up existing nvim config $TARGET"
  mv "$TARGET" "${TARGET}.backup.$(date +%s)"
fi

if [ -L "$TARGET" ]; then
    echo "removing existing symlink $TARGET"
    rm "$TARGET"
fi

mkdir -p "$(dirname "$TARGET")"

ln -s "$SOURCE" "$TARGET"
echo "symlink made $TARGET -> $SOURCE"

