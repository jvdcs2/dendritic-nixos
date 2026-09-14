export def get_niri_windows []: nothing -> list  {
  niri msg -j windows
  | from json
}

export def get_tmux_session_names [
  --server_name: string = "default"
]: nothing -> list<string> {
  tmux -L $server_name ls
  | lines
  | each {|e| ($e | split row ':').0}
  | str trim
}

export def get_appid_from_session [
  --name: string
]: nothing -> int {
  get_niri_windows  
  | where app_id =~ $name
  | get id.0
}

export def is_session_visible [
  --name: string
]: nothing -> bool {
  get_niri_windows 
  | any {|x| $x.app_id =~ $name}
}

export def is_session_existing [
  --session_name: string
  --server_name: string = "default"
]: nothing -> bool {
  get_tmux_session_names --server_name $server_name
  | any { |x| $x == $session_name }
}

export def fzf_tmux_session_names [] {
  get_tmux_session_names 
  | to text
  | (fzf
    --preview '''
    bash -c "
    echo \"$(tmux display-message -t {} -p \"|tabs:#{session_windows}| |@:#{=-16:pane_current_path}|\")\"
    tmux -L default capture-pane -t {} -p -e
    "
    '''
    --preview-window=85%
    --color=preview-fg:white)
}
