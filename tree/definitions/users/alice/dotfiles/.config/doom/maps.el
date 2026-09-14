;; Force the package to load first so we can overwrite it
(require 'org-typst-preview)

;; Overwrite the render function to POP UP errors
(defun org-typst-preview--render-image (typst-file-path image-file-path)
  "Render image and POP UP ERROR if it fails."
  (let* ((cmd (format "typst compile -f svg %s %s"
                      (shell-quote-argument typst-file-path)
                      (shell-quote-argument image-file-path)))
         (output (shell-command-to-string cmd)))
    ;; Check if the image file was created
    (if (file-exists-p image-file-path)
        0 ;; Success!
      ;; FAILURE: Pop up the error window
      (with-current-buffer (get-buffer-create "*Typst Error*")
        (erase-buffer)
        (insert "--- COMMAND FAILED ---\n")
        (insert cmd "\n\n")
        (insert "--- ERROR OUTPUT ---\n")
        (insert output)
        (pop-to-buffer (current-buffer)))
      1)))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "j") #'next-line)
  (define-key dired-mode-map (kbd "k") #'previous-line)
  (define-key dired-mode-map (kbd "h") #'dired-up-directory)
  (define-key dired-mode-map (kbd "l") #'dired-find-file)
  (define-key dired-mode-map (kbd "r") #'dired-do-rename)
  (define-key dired-mode-map (kbd "RET") #'dired-do-open)
  (define-key dired-mode-map (kbd ".") #'dired-omit-mode)
  (define-key dired-mode-map (kbd "C-SPC") (lambda () (interactive) (dired default-directory))))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "M-j") #'org-metadown)
            (local-set-key (kbd "M-k") #'org-metaup)
            (local-set-key (kbd "M-h") #'org-metaleft)
            (local-set-key (kbd "M-l") #'org-metaright)))

(global-set-key (kbd "M-P") #'evil-paste-before)
(global-set-key (kbd "M-p") #'evil-paste-after)

(require 'meow)

(defun find-then-show-subtree (pattern)
  (find-file "~/syncthing/org/_TD_.org")
  (sit-for 0) ; !!! wait for mode to load
  (goto-char (point-min))
  (when (search-forward pattern nil t)
    (org-back-to-heading t) ; move to headline
    (org-show-subtree)))

(defun turn-selection-into-link (filename)
  "Turn the selected text into a link to a new Org file in the same directory."
  (interactive "sNew filename (without extension): ")
  (let ((description (buffer-substring-no-properties (region-beginning) (region-end))))
    (delete-region (region-beginning) (region-end))
    (insert (format "[[file:%s.org][%s]]" filename description))))

(defun my/insert-target (id)
  "Inserts an anchor target <<ID>> at the current cursor position."
  (interactive "sEnter unique ID (e.g. ref1): ")
  (insert (format "<<%s>>" id)))

(defun my/turn-selection-into-internal-link (id)
  "Turns selection into a link pointing to the given ID."
  (interactive "sLink to which ID? (e.g. ref1): ")
  (if (use-region-p)
      (let ((text (buffer-substring-no-properties (region-beginning) (region-end))))
        (delete-region (region-beginning) (region-end))
        (insert (format "[[%s][%s]]" id text)))
    (insert (format "[[%s]]" id))))

(defun meow-setup ()
  (setq meow-esc-delay 0
        meow-keypad-describe-delay 0
        meow-expand-hint-remove-delay 0
        meow-keypad-start-keys '((?n . ?n) (?d . ?d) (?x . ?x) (?m . ?m) (?g . ?g))
        meow-mode-state-list '((conf-mode . normal)
                               (fundamental-mode . normal)
                               (help-mode . normal)
                               (special-mode . normal)
                               (helpful-mode . normal)
                               (dashboard-mode . normal)
                               (org-agenda-mode . normal)
                               (Info-mode . normal)
                               (prog-mode . normal)
                               (text-mode . normal)))

  (meow-leader-define-key
   '(". m" . (lambda () (interactive) (find-file "~/.config/doom/maps.el")))
   '(". c" . (lambda () (interactive) (find-file "~/.config/doom/config.org")))
   '(". o" . (lambda () (interactive) (find-file "~/syncthing/org")))
   '(". s" . (lambda () (interactive) (find-then-show-subtree "(sched)")))
   '(". t" . (lambda () (interactive) (find-then-show-subtree "(sch)")))
   '(". n" . (lambda () (interactive) (find-file (read-file-name "Create file: " "~/syncthing/org/main/"))))

   '("f" . find-file)
   '("r" . rename-buffer)

   '("o a" . org-agenda-list)
   '("o s" . org-time-stamp)
   '("o l" . turn-selection-into-link)
   '("o i" . org-insert-link)
   '("o r l" . my/turn-selection-into-internal-link)
   '("o r i" . my/insert-target)
   '("o b" . org-mark-ring-goto)

   '("b w" . save-buffer)
   '("b W" . save-some-buffers)
   '("b b" . consult-buffer)
   '("b n" . evil-buffer-new)
   
   '("w k" . evil-window-up)
   '("w j" . evil-window-down)
   '("w h" . evil-window-left)
   '("w l" . evil-window-right)
   
   '("w w" . evil-window-next)
   '("w r" . recentf-open-most-recent-file)
   '("w c" . kill-buffer-and-window)
   '("w W" . evil-window-prev)
   '("w s" . +evil/window-split-and-follow)
   '("w d" . +evil/window-vsplit-and-follow)
   '("w q" . +workspace/close-window-or-workspace)

   '("W n" . +workspace/new)
   '("W c" . +workspace/kill)
   '("W s" . +workspace/save)
   '("W l" . +workspace/load)

   '("H k" . helpful-key)
   '("H m" . helpful-macro)
   '("H s" . helpful-symbol)
   '("H f" . helpful-function)
   '("H v" . helpful-variable)
   
   '("h t" . meow-tutor)
   '("h i" . info)
   '("h f" . +lookup/file)
   '("h F" . describe-face)
   '("h D" . +lookup/definition)
   '("h r" . +lookup/references)
   '("h d" . +lookup/documentation)

   '("v o" . olivetti-mode)
   '("v t" . load-theme)
   )
  (meow-normal-define-key
   '("C-SPC" . (lambda () (interactive) (dired default-directory)))
   '("C--" . text-scale-decrease)
   '("C-=" . text-scale-increase)
   '("C-u" . meow-page-up)
   '("C-d" . meow-page-down)
   '("C-q" . previous-buffer)
   '("C-e" . next-buffer)
   '("C-n" . duplicate-line)

   '("g p" . centaur-tabs-backward)
   '("g n" . centaur-tabs-forward)
   '("g d" . evil-goto-definition)

   '("C-o" . evil-jump-forward)
   '("<C-i>" . evil-jump-backward)

   '("S" . evil-surround-edit)
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)

   '("a" . meow-append)
   '("i" . meow-insert)

   '("o" . meow-open-below)
   '("O" . meow-open-above)

   '("b" . meow-back-word)
   '("B" . meow-back-symbol)

   '("e" . meow-next-word)
   '("E" . meow-next-symbol)

   '("c" . meow-change)

   '("d" . delete-char)
   '("D" . backward-delete-char)

   '("f" . meow-find)

   '("<escape>" . meow-cancel-selection)
   '("G" . meow-grab)

   '("h" . meow-left)
   '("H" . meow-left-expand)

   '("j" . (lambda () (interactive) (next-line) (meow-cancel)))
   '("J" . meow-next-expand)
   '("K" . meow-prev-expand)
   '("k" . (lambda () (interactive) (previous-line) (meow-cancel)))

   '("l" . meow-right)
   '("L" . meow-right-expand)

   ;; '("m" . meow-join) useless
   '("m s" . evil-surround-edit)

   '("n" . meow-search)

   '("M-o" . meow-block)
   '("M-O" . meow-to-block)

   '("P" . evil-paste-before)
   '("p" . evil-paste-after)

   '("r" . meow-replace)
   '("R" . meow-swap-grab)

   '("s" . meow-kill)
   '("t" . meow-till)

   '("u" . undo)
   '("U" . undo-redo)

   '("/" . meow-visit)

   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)

   '("x" . meow-visual-line)
   '("X" . meow-line)

   '("y" . clipboard-kill-ring-save)

   '("'" . repeat)
   ))

(defun select-to-eol ()
  "Start selecting at point, then go to end of the logical line."
  (interactive)
  (set-mark-command nil)
  (end-of-line))
(meow-normal-define-key '("A" . select-to-eol))

(defun select-to-bol ()
  "Start selecting at point, then go to end of the logical line."
  (interactive)
  (set-mark-command nil)
  (beginning-of-line))
(meow-normal-define-key '("I" . select-to-bol))

(meow-setup)
(meow-global-mode 1)
(evil-mode -1)
