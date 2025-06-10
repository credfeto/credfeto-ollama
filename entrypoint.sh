#!/bin/bash

die() {
    echo
    echo "$@"
    exit 1
}

[ -z "$MODELS_TOLOAD" ] || die "MODELS_TO_LOAD not defined"

export OLLAMA_KEEP_ALIVE=-1 

# Start Ollama in the background.
/bin/ollama serve &
# Record Process ID.
pid=$!

# Pause for Ollama to start.
sleep 5

echo "Downloading Models..."
for MODEL in $MODELS_TO_LOAD; do
  echo "🔴 Retrieve $MODEL model..."
  ollama pull "$MODEL"
done
echo "🟢 Done!"

# Wait for Ollama process to finish.
wait $pid
