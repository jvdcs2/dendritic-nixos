. /etc/profile

while true; do
  procs=$(ps -e --no-headers | wc -l)
  printf '{"text":"󰔚 %s"}\n' "$procs"
  sleep 1
done
