export def dr [] {
  let answer = (input "Remove ~/.emacs.d and reinstall Doom Emacs? (y/N): ")
  if ($answer | str trim | str downcase) == "y" {
    rm -r ~/.emacs.d
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
    doom sync --rebuild --aot -u
  } else {
    print "Aborted."
  }
}

export def dm [name: string] {
  daemonize (which $name | get path.0) 
}

export def s [] {
  let here = (pwd)
  z /etc/nixos/
  git add . -A
  nh os switch /etc/nixos/ --impure
  z $here
}

export def p [msg: string] {
    let here = (pwd)
    z /etc/nixos/
    git add . -A

    try {
        git commit -m $msg
    } catch {
        # ignore the error, nothing to commit
    }

    git push -u origin master --force
    z $here
}

export def e [] {
  let here = (pwd)
  z /etc/nixos/
  nvim ./
  z $here
}

export def die [] {
  tmux kill-server
}

export def h [] {
  man home-configuration.nix
}

export def c [] {
  man configuration.nix
}

export def d [] {
  sudo nh clean all -v --nogcroots
}

export def listValidGpuFreq [] {
  let path = "/sys/class/drm/card1/gt_min_freq_mhz"

  for f in (seq 800 10 2200) {
    print $"NOW: ($f)"
    try {
      sudo sh -c $"echo ($f) > ($path)"
    } catch {
      print $"Could not write frequency ($f)"
    }
  }
}
