dir="$HOME/syncthing/org/_TD_.org"
pattern="${1:-}"  # pass pattern as argument

emacsclient -n -c -a "" -e "
(progn
  (find-file \"$dir\")
  (org-mode)
  (org-set-startup-visibility)
  (goto-char (point-min))
  (when (search-forward \"$pattern\" nil t)
    (org-back-to-heading t)
    (org-fold-show-subtree)))"
