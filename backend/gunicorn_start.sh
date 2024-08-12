#!/bin/bash
# Initialize the port variable
port=""

# Check if the "--port" parameter is passed
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --port)
            shift
            port="$1"
            ;;
        *)
            echo "Error: Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

# Check if the port variable is empty
if [[ -z "$port" ]]; then
    echo "Error: The '--port' parameter is required."
    exit 1
fi

PORT=$port
NAME=gemini_app
DIR=./
USER=www-data
GROUP=www-data
WORKERS=5
WORKER_CLASS=uvicorn.workers.UvicornWorker
VENV=$DIR/.venv/bin/activate
# BIND=unix:$DIR/run/gunicorn.sock
BIND=127.0.0.1:$PORT
LOG_LEVEL=debug
TIMEOUT=0

# Conditionally add the --reload option based on the port
RELOAD_OPTION=""
if [ "$PORT" -eq 5000 ]; then
    RELOAD_OPTION="--reload"
    WORKERS=1
fi

cd $DIR
source $VENV

exec gunicorn \
    $RELOAD_OPTION \
      app.main:app \
    --name $NAME \
    --workers $WORKERS \
    --worker-class $WORKER_CLASS \
    --bind=$BIND \
    --log-level=$LOG_LEVEL \
    --timeout=$TIMEOUT \
    --capture-output   
