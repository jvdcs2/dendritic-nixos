use lib-kmux.nu *
use std

def f [] {
  tmux -L default ls
  | lines
  | each {|e| ($e | split row ':').0}
  | to text
  | str trim
  | vicinae dmenu 
}

# λ let uid = (^id -u | str trim)
# let socket_dir = $"/run/user/($uid)/tmux-($uid)"
# let pattern = ($"($socket_dir)/*" | into glob)
#
# glob $pattern | each { |sock|
#     if (($sock | path type) == "socket") {
#         let name = ($sock | path basename)
#         try {
#           ^tmux -S $sock list-sessions
#         }
#     }
# } | lines | each {|e| ($e | split row ':').0}
# no server running on /run/user/1000/tmux-1000/kmux_YAZI
# ╭───┬──────────────────╮
# │ 0 │ kmux-SCREENSHOTS │
# │ 1 │ kmux-CONFIG      │
# │ 2 │ kmux-YAZI        │
# │ 3 │ kmux_0           │
# │ 4 │ kmux_1           │
# ╰───┴──────────────────╯


def main [] {
  let n = (f)
  if (is_session_visible --name $n) {
    niri msg action focus-window --id (get_appid_from_session --name $n | into int)
  } else {
    exec nohup sh -c $"kitty --class=kitty-($n) -- tmux attach -t ($n)" o+e> (std null-device)
  }
}
