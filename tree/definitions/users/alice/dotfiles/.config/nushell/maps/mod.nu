use fzf_cwd.nu *
use fzf_root.nu  *
use fzf_cwd_yazi.nu  *
use fzf_root_yazi.nu *
use fzf_files-in-cwd.nu *
use fzf_files-in-root.nu *

const alt_q = {
    name: "clear current entry"
    modifier: "alt" 
    keycode: "char_q" 
    mode: ["emacs", "vi_insert"] 
    event: { edit: clear }
}
const alt_s = {
    name: "move_cursor_end"
    modifier: "alt"
    keycode: "char_s"
    mode: ["emacs", "vi_insert"]
    event: { edit: movetolineend }
}
const alt_a = {
    name: "move_cursor_start"
    modifier: "alt"
    keycode: "char_a"
    mode: ["emacs", "vi_insert"]
    event: { edit: movetolinestart }
}
# const ctrl_s = {
#     name: "rg>fzf(cwd)>helix"
#     modifier: "control"
#     keycode: "char_s"
#     mode: ["emacs", "vi_insert"]
#     event: [
#       {
#         send: executehostcommand
#         cmd: "nu ~/.config/nushell/maps/functions/search.nu"
#       }
#     ]
# }
const ctrl_space = {
    name: "open yazi"
    modifier: "control" 
    keycode: "Space" 
    mode: ["emacs", "vi_insert"] 
    event: [
      {
        send: executehostcommand
        cmd: "y"
      }
    ]
}

export-env {
  $env.config.keybindings = $env.config.keybindings | append [
    $alt_c
    $shift_alt_c
    $alt_z
    $shift_alt_z
    $alt_y
    $shift_alt_y

    $ctrl_space
    $alt_q
    $alt_s
    $alt_a
    # $ctrl_s
  ]
}
