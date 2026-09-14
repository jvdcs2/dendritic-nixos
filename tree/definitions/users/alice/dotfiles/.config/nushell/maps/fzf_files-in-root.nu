export const shift_alt_z = {
  name: fzf_files
  modifier: alt_shift
  keycode: char_z
  mode: [emacs, vi_normal, vi_insert]
  event: [
    {
      send: executehostcommand
      cmd: "
        let fzf_ctrl_t_command = \"fd --full-path . $'/home/alice' --type=f --hidden | fzf --height=50% --preview 'bat --line-range=:1000 {}'\"; 
        let result = nu -l -i -c $fzf_ctrl_t_command;
        commandline edit --append $result;
        commandline set-cursor --end;
      "
    }
  ]
}
