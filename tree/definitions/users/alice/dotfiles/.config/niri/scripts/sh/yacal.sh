kitty --hold -- ssh \
  -L 8000:localhost:8000 \
  -L 5555:localhost:5555 \
  -L 8025:localhost:8025 \
  -L 9000:localhost:9000 \
  -t javed.sial@isl.yacal \
  'TERM=xterm-256color tmux new-session -A -s main'
