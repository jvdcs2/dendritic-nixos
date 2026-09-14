(setq org-agenda-files '("~/syncthing/org")
      org-agenda-scheduled-leaders '("" "")
      org-agenda-deadline-leaders '("" "" "")
      org-agenda-show-outline-path t
      org-agenda-prefix-format '((agenda . " %12t %b")
                                 (todo   . " %b")
                                 (tags   . " %b")
                                 (search . " %b"))
      org-agenda-breadcrumbs-separator " ")

(use-package org
  :config
  (setq org-agenda-span 16
        org-agenda-start-day "-2d"
        org-agenda-time-grid '((daily remove-match) () "" "")))
