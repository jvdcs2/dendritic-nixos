. /etc/profile

while true; do
  ret=$(nu -c '
  let c = (syncthing cli
  --gui-address 127.0.0.1:8384
  --gui-apikey nGgKfvsLnGeCoDWht4Z92Z2Xbftb3wSi show connections
  | from json
  | get connections
  | values)
  let total = ($c | length)
  let connected = ($c | where connected | length)
  {text: $"󰾰 ($connected)/($total)"} | to json')
  echo $ret
  sleep 1
done
