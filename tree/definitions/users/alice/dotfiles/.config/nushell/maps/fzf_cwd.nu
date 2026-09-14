export const alt_c_cmd = "
  let fd = \"fd --type=directory --hidden\"
  let fzf = \"fzf --height=50% --preview 'eza -TL=2 --icons=always --color=always --sort=type {} | head -n 1000'\";
  let cmd = $\"($fd) | ($fzf)\"; 
  let result = nu -c $cmd;
  z $result;
  clear;
"
export const alt_c = {
  name: fzf_cwd
  modifier: alt
  keycode: char_c
  mode: [emacs, vi_normal, vi_insert]
  event: [
    {
      send: executehostcommand
      cmd: $alt_c_cmd
    }
  ]
}
