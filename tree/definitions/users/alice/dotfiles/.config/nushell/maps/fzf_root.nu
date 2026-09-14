export const shift_alt_c_cmd = "
  let fd = \"fd --full-path . $'/home/alice' --type=directory --hidden\";
  let fzf = \"fzf --height=50% --preview 'eza -TL=2 --icons=always --color=always --sort=type {} | head -n 1000'\";
  let cmd = $\"($fd) | ($fzf)\"; 
  let result = nu -c $cmd;
  z $result;
  clear;
"; 
export const shift_alt_c = {
  name: fzf_root
  modifier: shift_alt
  keycode: char_c
  mode: [emacs, vi_normal, vi_insert]
  event: [
    {
      send: executehostcommand
      cmd: $shift_alt_c_cmd
    }
  ]
}
