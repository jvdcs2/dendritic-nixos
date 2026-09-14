. /etc/profile

PIDFILE="$HOME/.rec_pid"
TIMER_PIDFILE="$HOME/.rec_timer_pid"
STATEFILE="$HOME/.rec_state.json"
LOCKFILE="$HOME/.rec_lock"

# Ensure state file exists
[ ! -f "$STATEFILE" ] && echo '{"text":"REC OFF"}' > "$STATEFILE"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    # Stop recording
    REC_PID=$(cat "$PIDFILE")
    kill -INT "$REC_PID"
    rm -f "$PIDFILE"

    # Failsafe: Kill timer process if it's still running
    if [ -f "$TIMER_PIDFILE" ]; then
        kill "$(cat "$TIMER_PIDFILE")" 2>/dev/null
        rm -f "$TIMER_PIDFILE"
    fi

    echo '{"text":" "}' > "$STATEFILE"
else
    # Prevent running slurp twice
    if [ -f "$LOCKFILE" ]; then
        exit 1
    fi
    touch "$LOCKFILE"

    geo=$(slurp)

    # Handle slurp cancellation (e.g., user pressed 'Esc')
    if [ -z "$geo" ]; then
        rm -f "$LOCKFILE"
        exit 0
    fi

    # Ensure directory exists and generate dynamic filename
    OUT_DIR="$HOME/saves/videos/rec"
    mkdir -p "$OUT_DIR"
    FILENAME="vid-$(date +'%S:%M:%H-%d-%m-%Y').mp4"
    OUTPUT="$OUT_DIR/$FILENAME"

    # Start recording
    wf-recorder -a -g "$geo" -f "$OUTPUT" -r 30 -x yuv420p -p color_range=1 -p color_primaries=1 -p colorspace=1 -p color_trc=1 &
    REC_PID=$!
    echo $REC_PID > "$PIDFILE"

    # Start background timer process
    (
        START_TIME=$(date +%s)

        # Loop as long as the recorder process is running
        while kill -0 "$REC_PID" 2>/dev/null; do
            NOW=$(date +%s)
            ELAPSED=$((NOW - START_TIME))
            MINS=$((ELAPSED / 60))
            SECS=$((ELAPSED % 60))
            
            TIMER_TEXT=$(printf " %02d:%02d" $MINS $SECS)
            echo "{\"text\":\"$TIMER_TEXT\",\"class\":\"recording\"}" > "$STATEFILE"
            pkill -RTMIN+1 waybar
            sleep 1
        done

        # When recorder stops, reset state and clean up timer PID
        echo '{"text":" "}' > "$STATEFILE"
        pkill -RTMIN+1 waybar
        rm -f "$TIMER_PIDFILE"
    ) &
    TIMER_PID=$!
    echo $TIMER_PID > "$TIMER_PIDFILE"

    disown $REC_PID $TIMER_PID
    rm -f "$LOCKFILE"
fi

# Refresh Waybar module
pkill -RTMIN+1 waybar
