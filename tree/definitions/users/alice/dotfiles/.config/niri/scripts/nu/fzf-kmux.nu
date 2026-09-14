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

def main [] {
  let n = (f)
  if (is_session_visible --name $n) {
    # focus window with specified session
    niri msg action focus-window --id (get_appid_from_session --name $n | into int)
  } else {
    # exec nohup new kitty with specified session
    exec nohup sh -c $"kitty --class=kitty-($n) -- tmux attach -t ($n)" o+e> (std null-device)
  }
}
