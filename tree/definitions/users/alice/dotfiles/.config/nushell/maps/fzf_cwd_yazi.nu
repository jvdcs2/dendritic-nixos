export const alt_y_cmd = "
  let fd = \"fd --type=directory --hidden\"
  let fzf = \"fzf --height=50% --preview 'eza -TL=2 --icons=always --color=always --sort=type {} | head -n 1000'\";
  let cmd = $\"($fd) | ($fzf)\"; 
  let result = nu -c $cmd;
  y $result;
"
export const alt_y = {
  name: fzf_cwd
  modifier: alt
  keycode: char_y
  mode: [emacs, vi_normal, vi_insert]
  event: [
    {
      send: executehostcommand
      cmd: $alt_y_cmd
    }
  ]
}
