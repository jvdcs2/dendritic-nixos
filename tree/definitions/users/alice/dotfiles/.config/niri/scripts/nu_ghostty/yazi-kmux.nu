use lib-kmux.nu *
use std

def main [path?: string] {
    let n = "kmux-yazi"
    let target_title = $"ghostty-($n)"
    
    # 1. Use 'str contains' to match the window even if Yazi/Tmux modifies the title
    let niri_windows = (
        niri msg -j windows 
        | from json 
        | where { |w| ($w | get -i title | default "") | str contains $n }
    )

    if not ($niri_windows | is-empty) {
        # Window exists -> jump to it
        let window_id = $niri_windows.0.id
        niri msg action focus-window --id $window_id
    } else if (is_session_existing --session_name $n) {
        # Session exists but no window -> spawn window and attach
        exec nohup sh -c $"ghostty +new-window --title=($target_title) -e tmux attach -t ($n)" o+e> (std null-device)
    } else {
        # Nothing exists -> start fresh window and new tmux session
        let p = if ($path == null) { "" } else { $path }
        # 2. Wrap new-session in nohup so it matches the attach behavior exactly
        exec nohup sh -c $"ghostty +new-window --title=($target_title) -e tmux new-session -s ($n) nu -e 'y ($p)'" o+e> (std null-device)
    }
}
