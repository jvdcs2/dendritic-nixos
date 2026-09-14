export const alt_z = {
  name: fzf_files
  modifier: alt
  keycode: char_z
  mode: [emacs, vi_normal, vi_insert]
  event: [
    {
      send: executehostcommand
      cmd: "
        let fzf_ctrl_t_command = \"fd --type file --hidden | fzf --height=50% --preview 'bat --line-range=:1000 {}'\"; 
        let result = nu -l -i -c $fzf_ctrl_t_command;
        commandline edit --append $result;
        commandline set-cursor --end;
      "
    }
  ]
}
