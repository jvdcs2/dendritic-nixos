# def g_kmux_count [] {
#   tmux list-session
#   | lines
#   | where $it =~ "kmux_"
#   | length
# }
#
# def n_kmux_instance [] {
#   let count = g_kmux_count
#   kitty --class $"kitty-kmux_($count)" -- tmux new-session -s $"kmux_($count)" 
# }
#
# n_kmux_instance

def g_kmux_count [] {
  tmux list-session
  | lines
  | where $it =~ "kmux_"
  | length
}

# def n_kmux_instance [] {
#   let count = g_kmux_count
#   ghostty --class=$"sh.ghostty.kmux.session-($count)" -e tmux new-session -s $"kmux_($count)"
# }

def n_kmux_instance [] {
  let count = g_kmux_count
  # Drop --class so it hits the background daemon. Name the window with --title instead.
  ghostty +new-window --title=$"sh.ghostty.kmux.session-($count)" -e tmux new-session -s $"kmux_($count)"
}

n_kmux_instance
