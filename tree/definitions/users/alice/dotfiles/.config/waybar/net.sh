. /etc/profile

iface="wlo1"

while true; do
  rx1=$(< /sys/class/net/$iface/statistics/rx_bytes)
  tx1=$(< /sys/class/net/$iface/statistics/tx_bytes)
  sleep 1
  rx2=$(< /sys/class/net/$iface/statistics/rx_bytes)
  tx2=$(< /sys/class/net/$iface/statistics/tx_bytes)

  rx_rate=$(( (rx2 - rx1) / (1024) ))
  tx_rate=$(( (tx2 - tx1) / (1024) ))

  printf '{"text":"↓%s↑%skb"}\n' "$rx_rate" "$tx_rate"
done
