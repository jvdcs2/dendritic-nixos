use zoxide.nu z  

export def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    
    if ($tmp | path exists) {
        let cwd = (open $tmp | str trim)
        if $cwd != "" and $cwd != $env.PWD {
            z $cwd  
        }
        rm -fp $tmp
    }
}
