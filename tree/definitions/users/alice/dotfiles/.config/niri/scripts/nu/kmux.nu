use lib-kmux.nu *
use std

def main [
  --instance: string, 
  --config: string = "kmux.conf",
  --command: string = "echo 'Hello World'"
] {
    let n = $instance
    let conf = ($env.HOME | path join $".config/tmux/($config)") 
    let exists = (tmux -L $n has-session -t $n | complete).exit_code == 0

    if $exists {
        if (is_session_visible --name $n) {
            niri msg action focus-window --id (get_appid_from_session --name $n | into int)
        } else {
            exec nohup sh -c $"kitty --class=kitty-($n) -- tmux -L ($n) attach -t ($n)" o+e> (std null-device)
        }
    } else {
        let tmux_cmd = [tmux -L $n -f $conf new-session -s $n nu -e $command]
        kitty --class $"kitty-($n)" -- ...$tmux_cmd
    }
}

