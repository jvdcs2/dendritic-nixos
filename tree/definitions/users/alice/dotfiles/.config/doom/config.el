(after! gcmh
  (setq gcmh-high-cons-threshold (* 1024 1024 1024)
        gcmh-low-cons-threshold  (* 32 1024 1024)
        inhibit-compacting-font-caches nil))

(setq redisplay-dont-pause t)
(setq process-adaptive-read-buffering nil)

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(after! corfu
  (setq corfu-auto t
        corfu-auto-delay 0
        corfu-auto-prefix 1
        corfu-popupinfo-delay '(0.0 . 0.0)))

(after! consult
(setq consult-async-refresh-delay 0
      consult-async-input-debounce 0
      consult-async-input-throttle 0
      consult-async-min -input 0))

(setq
      tooltip-delay 0
      read-key-delay 0
      evil-esc-delay 0
      eldoc-idle-delay 0
      idle-update-delay 0
      evil-escape-delay 0
      sp-show-pair-delay 0
      flymake-popon-delay 0
      tooltip-short-delay 0
      bookmark-search-delay 0
      diff-hl-flydiff-delay 0
      org-link-preview-delay 0
      register-preview-delay 0
      image-default-frame-delay 0
      image-minimum-frame-delay 0
      browse-url-text-input-delay 0
      lazy-highlight-initial-delay 0
      lazy-highlight-no-delay-length 0
      doom-switch-frame-hook-debounce-delay 0)

(setq read-process-output-max (* 4 1024 1024 1024)
      gc-cons-threshold       (* 128 1024 1024))

(after! lsp-mode
  (setq lsp-log-io nil
        lsp-enable-symbol-highlighting nil
        lsp-enable-on-type-formatting nil
        lsp-signature-auto-activate nil
        lsp-signature-render-documentation nil
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-headerline-breadcrumb-enable nil
        lsp-enable-folding nil
        lsp-enable-imenu nil
        lsp-enable-snippet nil
        lsp-enable-links nil
        lsp-enable-file-watchers nil
        lsp-idle-delay 0))

(setq bidi-display-reordering nil
      bidi-paragraph-direction 'left-to-right
      display-line-numbers-type nil
      mode-line-format nil
      fast-but-imprecise-scrolling t
      scroll-conservatively 10000
      scroll-margin 0
      jit-lock-defer-time 0
      jit-lock-stealth-time nil)

(global-hl-line-mode -1)
(global-so-long-mode 1)
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
(advice-add #'global-hl-line-mode :override #'ignore)
(advice-add #'hl-line-mode :override #'ignore)

(defun my/insert-clipboard-image (filename)
  "Paste PNG from clipboard into ./images/, insert Org link."
  (interactive "sFilename (no extension): ")
  (let* ((dir (file-name-directory (or buffer-file-name default-directory)))
         (img-dir (expand-file-name "images/" dir))
         (file (expand-file-name
                (concat (format-time-string "%Y%m%d-")
                        filename ".png")
                img-dir)))
    (unless (file-directory-p img-dir)
      (make-directory img-dir t))
    (if (= 0
           (shell-command
            (format "wl-paste --type image/png > %s" (shell-quote-argument file))))
        (progn
          (insert (format "[[file:%s]]" (file-relative-name file)))
          (org-display-inline-images))
      (message "No image in Wayland clipboard."))))

(setenv "WAYLAND_DISPLAY" "wayland-1")

(setq
 user-full-name "jvdcs"
 user-mail-address "javedcorreossial@gmail.com"
 shell-file-name "/run/current-system/sw/bin/bash"
 browse-url-browser-function #'browse-url-generic
 browse-url-generic-program "/etc/profiles/per-user/alice/bin/zen-beta")

(after! treesit
  (add-to-list 'treesit-language-source-alist
    '(typst "https://github.com/uben0/tree-sitter-typst" "master" nil)))

(setq +file-templates-inhibit t)

(auto-insert-mode -1)

(require 'mailcap)
(setq mailcap-user-mime-data
      '(((type . "application/pdf")
         (viewer . "sioyek %s"))

        ((type . "image/*")
         (viewer . "swayimg %s"))

        ((type . "video/*")
         (viewer . "mpv %s"))

        ((type . "audio/*")
         (viewer . "mpv %s"))))

(use-package dashboard
  :init (dashboard-setup-startup-hook)
  :ensure t
  :config
  (setq initial-buffer-choice (lambda () (get-buffer dashboard-buffer-name))
        ;; dashboard-banner-logo-title "Time to synthesize evil oganesson"
        dashboard-banner-logo-title nil
        dashboard-agenda-sort-strategy '(time-up)
        dashboard-icon-type 'nerd-icons
        dashboard-set-heading-icons t
        dashboard-show-shortcuts nil
        dashboard-set-file-icons t
        dashboard-center-content t
        dashboard-startup-banner 3
        dashboard-items '(
                          ;; (bookmarks . 4)
                          ;; (recents. 4)
                          (agenda . 4)
                          ))
  (setq dashboard-startupify-list
        '(dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-newline
          dashboard-insert-banner
          dashboard-insert-banner-title
          dashboard-insert-items)))
(after! dashboard
  (setq dashboard-display-icons-p t
        doom-fallback-buffer-name "*dashboard*"))

(defun my/hide-dashboard-mode-line ()
  "Hide mode-line in the dashboard buffer."
  (when (string= (buffer-name) "*dashboard*")
    (setq mode-line-format nil)))
(add-hook 'window-configuration-change-hook #'my/hide-dashboard-mode-line)

(use-package! olivetti
  :commands olivetti-mode
  :init (add-hook!
          (
           org-agenda-mode
           markdown-mode
           helpful-mode
           diredfl-mode
           text-mode
           org-mode
           )
          #'olivetti-mode))

(setq x-stretch-cursor t
      meow-cursor-type-normal 'box
      meow-cursor-type-insert '(bar . 2))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)
(setq diredp-hide-details-initially-flag t)
;; Always hide details in Dired
(add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1)))
(use-package dirvish
  :ensure t
  :config
  (dirvish-override-dired-mode)
  (setq dirvish-hide-details t))
(add-hook 'dired-mode-hook #'dired-omit-mode)
(setq dired-omit-files (rx (seq bol ".")))

(setq
 doom-font                 (font-spec
                            ;; :family "JuliaMono"
                            ;; :family "MonoLisa"
                            ;;:family "JetbrainsMono Nerd Font"
                            :family "IoskeleyMono Nerd Font Medium"
                            :size 15
                            :weight 'medium)
 doom-serif-font           (font-spec
                            :family "DeepMind Sans"
                            :size 15
                            :weight 'semi-bold)
 doom-variable-pitch-font  (font-spec
                            :family "Eczar"
                            :size 15))

(setq centaur-tabs-show-new-tab-button nil
      centaur-tabs-right-edge-margin ""
      centaur-tabs-set-close-button nil
      centaur-tabs-left-edge-margin ""
      centaur-tabs-set-bar nil
      centaur-tabs-height 12
      centaur-tabs-set-icons nil)

(defun my/set-scroll-margin-locally ()
  (setq-local scroll-margin 10))
(add-hook 'prog-mode-hook #'my/set-scroll-margin-locally)
(add-hook 'text-mode-hook #'my/set-scroll-margin-locally)

(spacious-padding-mode +1)
(require 'spacious-padding)
(setq spacious-padding-widths
      '(
         :internal-border-width 10
         :right-divider-width 0
         :header-line-width 0
         :scroll-bar-width 0
         :mode-line-width 0
         :fringe-width 0
         :tab-width 0
         ))
;; (setq-default line-spacing 0.2)

(doom/set-frame-opacity 100)
(+global-word-wrap-mode +1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq large-file-warning-threshold nil
      display-line-numbers-width 0
      initial-scratch-message nil
      inhibit-startup-message t
      which-key-idle-delay 0.0
      global-hl-line-modes nil
      doom-theme 'doom-Trasmus
      ;; doom-theme 'doom-ashen
      which-key-idle-delay 0
      +modeline-height 20
      show-paren-delay 0)

(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(set-display-table-slot standard-display-table
                        'truncation (make-glyph-code ? 'default))

(after! vertico
  (define-key! :keymaps +default-minibuffer-maps
    "M-j" #'vertico-next
    "M-k" #'vertico-previous
    "M-h" #'vertico-directory-up
    "M-l" #'vertico-directory-enter
    ))

(load! "maps.el")

(add-hook 'server-after-make-frame-hook
          (lambda ()
            ;; check if the current buffer is the dashboard
            (when (string= (buffer-name) "*dashboard*")
              ;; safely revert it
              (ignore-errors
                (revert-buffer t t t)))))


(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("extarticle"
                 "\\documentclass[14pt,a4paper]{extarticle}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(add-to-list 'display-buffer-alist
             '("^\\*helpful" . (display-buffer-same-window)))

(load! "org-agenda.el")
(add-hook 'org-mode-hook (lambda () (corfu-mode -1)))
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))
(setq org-startup-folded t)

(use-package! org-modern
  :config
  (setq org-modern-fold-stars '(("󰴈" . "󰴈") ("◉" . "◉") ("" . "") ("󰫣" . "󰫣"))
        org-modern-list '((?+ . "◦") (?- . "–") (?* . "•"))
        org-modern-checkbox '((?  . "○") (?- . "◐") (?X . "●"))
        org-modern-table-horizontal 0.2
        org-modern-table-vertical 1))
(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
(global-org-modern-mode)

(setq org-catch-invisible-edits 'show-and-error
      org-insert-heading-respect-content t
      org-hide-emphasis-markers t
      org-auto-align-tags nil
      org-special-ctrl-a/e t
      org-pretty-entities t
      org-ellipsis " ..."
      org-tags-column 0)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default org-display-custom-times t)
(after! org
  (setq org-image-actual-width 500
        org-startup-with-inline-images t))

(defun my/org-src-block-font-setup ()
  (set-face-attribute 'org-block-begin-line nil :family "DeepMind Sans")
  (set-face-attribute 'org-block-end-line nil :family "DeepMind Sans"))
(add-hook 'org-mode-hook #'my/org-src-block-font-setup)
