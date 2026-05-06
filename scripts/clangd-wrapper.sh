#!/bin/sh
# Запускает clangd с XDG_CACHE_HOME внутри проекта, рядом с compile_commands.json
# Переживает пересоздание контейнера если проект примонтирован как volume

ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$ROOT" ]; then
  ROOT="$PWD"
fi

export XDG_CACHE_HOME="$ROOT/.cache"
exec "$@"
