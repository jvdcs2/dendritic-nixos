. /etc/profile

while true; do
  ret=$(nu ~/.config/waybar/waybar-agenda.nu)
  echo $ret
  sleep 3600
done
