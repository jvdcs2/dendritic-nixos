use lib-kmux.nu *
use std
def main [path?: string] {
    let n = "kmux-yazi"
    if (is_session_existing --session_name $n) {
        if (is_session_visible --name $n) {
            niri msg action focus-window --id (get_appid_from_session --name $n | into int)
        } else {
            exec nohup sh -c $"kitty --class=kitty-($n) -- tmux attach -t ($n)" o+e> (std null-device)
        }
    } else {
        kitty --class $"kitty-($n)" -- tmux new-session -s ($n) nu -e $"y ($path)"
    }
}
