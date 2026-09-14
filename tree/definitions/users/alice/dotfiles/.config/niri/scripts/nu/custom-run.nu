def main [] {
    let script_dir = ("~/.config/niri/scripts/nu/custom-run/" | path expand)
    
    let scripts = (ls $script_dir 
        | where name ends-with '.sh'
        | select name 
        | insert stem { get name | path parse | get stem })

    let choice = ($scripts.stem 
        | str join (char nl) 
        | vicinae dmenu 
        | str trim)

    if ($choice == "") { return }

    let match = ($scripts | where {|it| 
        ($choice | str contains $it.stem) 
    } | first)

    if ($match != null) {
        ^bash $match.name
    }
}
