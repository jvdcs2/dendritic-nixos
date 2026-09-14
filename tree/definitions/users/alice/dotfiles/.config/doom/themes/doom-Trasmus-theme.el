(require 'doom-themes)


;;
;;; Variables

(defgroup doom-Tflexoki-theme nil
  "Options for the doom-Trasmus theme."
  :group 'doom-themes)

(defcustom doom-Tflexoki-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-Tflexoki-theme
  :type '(choice integer boolean))

(defcustom doom-Tflexoki-blue-modeline nil
  "If non-nil, mode-line's color will be blue instead of the default purple."
  :group 'doom-Tflexoki-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-Trasmus
    "Rasmus theme!"

  ;; name         default    256        16
  ((bg          '("#1a1a19" "#1a1a19" nil))
      (bg-alt      '("#222221" "#222221" nil))
      (bg-alt2      '("#2a2a29" "#2a2a29" nil))
      (base0       '("#323231" "#323231" "black"))
      (base1       '("#333332" "#333332" "brightblack"))
      (base2       '("#4b4b4a" "#4b4b4a" "brightblack"))
      (base3       '("#6c6c6a" "#6c6c6a" "brightblack"))
      (base4       '("#767675" "#767675" "brightblack"))
      (base5       '("#767675" "#767675" "brightblack"))
      (base6       '("#d1d1d1" "#d1d1d1" "brightblack"))
      (base7       '("#d1d1d1" "#d1d1d1" "brightblack"))
      (base8       '("#d1d1d1" "#d1d1d1" "white"))
      (fg          '("#d1d1d1" "#d1d1d1" "brightwhite"))
      (fg-alt      '("#767675" "#767675" "white"))

      (grey base7)
      (white        '("#d1d1d1" "#d1d1d1" "white"))
      (red          '("#ff968c" "#ff968c" "red"))
      (orange       '("#ffc591" "#ffc591" "brightred"))
      (green        '("#60967d" "#60967d" "green"))
      (light-green  '("#60967d" "#60967d" "green"))
      (teal         '("#60967d" "#60967d" "brightgreen"))
      (yellow       '("#ffc591" "#ffc591" "brightyellow"))
      (blue         '("#86adcd" "#86adcd" "brightblue"))
      (dark-blue    '("#86adcd" "#86adcd" "blue"))
      (magenta      '("#de9bc8" "#de9bc8" "brightmagenta"))
      (violet       '("#de9bc8" "#de9bc8" "magenta"))
      (dark-violet  '("#de9bc8" "#de9bc8" "mageta"))
      (cyan         '("#499294" "#499294" "brightcyan"))
      (dark-cyan    '("#499294" "#499294" "cyan"))
      (pure-white   '("#d1d1d1" "#d1d1d1" "white"))
      (pure-black   '("#181818" "#181818" "black"))

   (highlight       white)
   (vertical-bar    base2)
   (selection       blue)
   (builtin         green)
   (comments        base2)
   (doc-comments    fg)
   (constants       violet)
   (functions       green)
   (keywords        base4)
   (methods         green)
   (operators       base3)
   (type            blue)
   (strings         cyan)
   (variables       blue)
   (numbers         violet)
   (region          base4)
   (error           red)
   (warning         yellow)
   (success         green)
   (vc-modified     blue)
   (vc-added        green)
   (vc-deleted      red)

   ;; custom categories
   (modeline-bg     bg-alt)
   (modeline-bg-alt bg)
   (modeline-fg     fg)
   (modeline-fg-alt fg)

   (-modeline-pad
    (when doom-Tflexoki-padded-modeline
      (if (integerp doom-Tflexoki-padded-modeline) doom-Tflexoki-padded-modeline 4))))

  (((highlight &override) :foreground base8)
   (lazy-highlight :background base4 :foreground fg :weight 'bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-alt :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (tooltip :background base2 :foreground fg)
   (line-number :foreground base2 :background bg)
   (line-number-current-line :foreground white :background bg)
   (fringe ((t (:foreground violet :background bg))))

   ;;;; MINEEEEEEEEEEE
   (secondary-selection :foreground white :background base2)
   (tab-line :background bg) ; LEFTOVER SPACE FROM TAB BAR

   ;;;; all-the-icons
   (all-the-icons-dblue    :foreground blue)
   ;;;; centaur-tabs
   (centaur-tabs-unselected :background bg :foreground base2)
   (centaur-tabs-selected :background bg-alt2 :foreground fg)
   (centaur-tabs-active-bar-face :background bg)
   (centaur-tabs-selected-modified
    :inherit 'centaur-tabs-selected :foreground fg :weight 'bold)
   (centaur-tabs-unselected-modified
    :inherit 'centaur-tabs-unselected :foreground fg :weight 'bold)
   (centaur-tabs-modified-marker-selected
    :inherit 'centaur-tabs-selected :foreground fg)
   (centaur-tabs-modified-marker-unselected
    :inherit 'centaur-tabs-unselected :foreground fg)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; dashboard
   (dashboard-heading :foreground green :weight 'bold)
   (dashboard-text-banner :foreground base2 :weight 'bold)
   (dashboard-banner-logo-title :foreground base2)
   ;;;; dired-k
   (diredfl-date-time :foreground base6)
   (diredfl-number :foreground base4)
   (diredfl-dir-priv :foreground base3)
   (diredfl-exec-priv :foreground base4)
   (diredfl-link-priv :foreground base5)
   (diredfl-read-priv :foreground base6)
   (diredfl-other-priv :foreground base7)
   (diredfl-write-priv :foreground base8)

   (diredfl-flag-mark-line :background bg)
   (diredfl-flag-mark      :background bg)

   (dired-k-commited :foreground base4)
   (dired-k-modified :foreground vc-modified)
   (dired-k-ignored :foreground cyan)
   (dired-k-added    :foreground vc-added)
   ;;;; org <built-in>
   ((org-block &override) :background bg)
   ((org-block-background &override) :background bg)
   ((org-block-begin-line &override) :background bg)
   ;;;; org levels
   ((org-level-1 &override) :foreground green)
   ((org-level-2 &override) :foreground blue)
   ((org-level-3 &override) :foreground magenta)
   ((org-level-4 &override) :foreground cyan)
   ((org-level-5 &override) :foreground green)
   ((org-level-6 &override) :foreground blue)
   ((org-level-7 &override) :foreground magenta)
   ((org-level-8 &override) :foreground cyan)
   ;;;; org agenda
   ((org-agenda-date &override)
    :foreground blue
    :italic t
    :weight 'medium)
   ((org-agenda-date-today &override)
    :foreground bg
    :italic t
    :background blue
    :weight 'medium)
   ((org-agenda-date-weekend &override)
    :foreground base2
    :italic t
    :weight 'medium)
   ((org-scheduled-previously &override)
    :foreground red
    :italic t
    :weight 'medium)


   ;; (meow-position-highlight-number :background red :foreground base2)
   ;; (meow-position-highlight-number-1 :background red :foreground base3)
   ;; (meow-position-highlight-number-2 :background red :foreground base4)
   ;; (meow-position-highlight-number-3 :background red :foreground base5)
   ;;;; MINE FOR ORG ==================================
   ((org-meta-line &override) :foreground base2 :background bg)
   ((org-document-info-keyword &override) :foreground base2 :background bg)
   ((org-headline-done &override) :foreground base2 :background bg)
   ((org-special-keyword &override) :foreground base2 :background bg)
   ;;;; CORFU ========================================
   (vertico-current :background bg-alt :foreground fg)
   (corfu-default :background bg-alt)
   (corfu-border :foreground bg :background bg)
   (corfu-bar :background base0)
   (orderless-match-face-0
    :foreground fg
    :background green)
   (region :background green :foreground fg :inverse-video nil)
   (highlight :background fg :foreground bg :inverse-video nil)
   ;;;;ORG MODERN
   (org-modern-date-active
    :background base1
    :family "DeepMind Sans"
    :height 88
    :weight 'bold
    :foreground pure-white)
   (org-modern-time-active
    :background fg
    :height 88
    :weight 'bold
    :family "DeepMind Sans"
    :foreground base3)
   (org-modern-label
    :height 88
    :weight 'bold
    :family "DeepMind Sans")

   ;;;; WORKSPACES
   (+workspace-tab-selected-face :foreground teal)

   (whitespace-tab :background bg :foreground bg)
   ;; ==================================================

   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground base2)
   (rainbow-delimiters-depth-2-face :foreground base3)
   (rainbow-delimiters-depth-3-face :foreground base4)
   (rainbow-delimiters-depth-4-face :foreground base2)
   (rainbow-delimiters-depth-5-face :foreground base3)
   (rainbow-delimiters-depth-6-face :foreground base4)
   (rainbow-delimiters-depth-7-face :foreground base2)
   (rainbow-delimiters-depth-8-face :foreground base3)
   (rainbow-delimiters-depth-9-face :foreground base4)
   ;;;; show-paren
   (show-paren-match :foreground pure-white :background base2)
   (show-paren-mismatch :foreground pure-white :background red)
   ;;;; marginalia
   (marginalia-priv-dir  :foreground fg)
   (marginalia-priv-exec :foreground fg)
   (marginalia-priv-link :foreground fg)
   (marginalia-owner     :foreground fg)
   (marginalia-group     :foreground fg)
   (marginalia-size      :foreground fg)
   (marginalia-date      :foreground fg)
   (marginalia-file-name :foreground fg)
   ;; Shadowed text like consult separators
   (shadow :foreground base0)
   (consult-highlight-match :foreground fg :background green)
   (consult-highlight-mark :foreground fg :background green)
   (evil-ex-lazy-highlight :foreground fg :background green)
   (evil-mc-cursor-default-face :foreground pure-white :background blue)


   ;;;; TREESITTER -------------
   (tree-sitter-hl-face:property :foreground fg :italic nil)
   ))

;;; doom-Tflexoki-theme.el ends here
