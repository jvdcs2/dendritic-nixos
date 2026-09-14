def g_kmux_count [] {
  tmux list-session
  | lines
  | where $it =~ "kmux_"
  | length
}

def n_kmux_instance [] {
  let count = g_kmux_count
  kitty --class $"kitty-kmux_($count)" -- tmux new-session -s $"kmux_($count)" 
}

n_kmux_instance
