(require 'doom-themes)

;;
;;; Variables

(defgroup doom-ashen-theme nil
  "Options for the doom-ashen theme."
  :group 'doom-themes)

(defcustom doom-ashen-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-ashen-theme
  :type '(choice integer boolean))

(defcustom doom-ashen-blue-modeline nil
  "If non-nil, mode-line's color will be blue instead of the default purple."
  :group 'doom-ashen-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-ashen
    "Ashen theme."

  ;; name          default    256       16
  ((bg          '("#121212" "#121212" nil))       ; background
   (bg-alt      '("#151515" "#151515" nil))       ; g_12
   (bg-alt2     '("#191919" "#191919" nil))       ; g_11 / cursorline
   (base0       '("#212121" "#212121" "black"))   ; g_9
   (base1       '("#323232" "#323232" "brightblack")) ; g_8
   (base2       '("#535353" "#535353" "brightblack")) ; g_7
   (base3       '("#737373" "#737373" "brightblack")) ; g_6
   (base4       '("#949494" "#949494" "brightblack")) ; g_5
   (base5       '("#a7a7a7" "#a7a7a7" "brightblack")) ; g_4
   (base6       '("#b4b4b4" "#b4b4b4" "brightblack")) ; g_3
   (base7       '("#d5d5d5" "#d5d5d5" "brightblack")) ; g_2
   (base8       '("#e5e5e5" "#e5e5e5" "white"))       ; g_1
   (fg          '("#b4b4b4" "#b4b4b4" "brightwhite")) ; text
   (fg-alt      '("#949494" "#949494" "white"))       ; g_5

   (grey base4)
   (white       '("#e5e5e5" "#e5e5e5" "white"))
   (red         '("#DF6464" "#DF6464" "red"))          ; red_glowing
   (orange      '("#D87C4A" "#D87C4A" "brightred"))    ; orange_glow
   (green       '("#E5A72A" "#E5A72A" "green"))        ; orange_golden (mapped)
   (light-green '("#E49A44" "#E49A44" "green"))        ; orange_smolder (mapped)
   (teal        '("#4A8B8B" "#4A8B8B" "brightgreen"))  ; blue
   (yellow      '("#E49A44" "#E49A44" "brightyellow")) ; orange_smolder (mapped)
   (blue        '("#4A8B8B" "#4A8B8B" "brightblue"))   ; blue
   (dark-blue   '("#4A8B8B" "#4A8B8B" "blue"))         ; blue
   (magenta     '("#B14242" "#B14242" "brightmagenta")); red_ember
   (violet      '("#B14242" "#B14242" "magenta"))      ; red_ember
   (dark-violet '("#89492a" "#89492a" "magenta"))      ; brown
   (cyan        '("#4A8B8B" "#4A8B8B" "brightcyan"))   ; blue (mapped)
   (dark-cyan   '("#4A8B8B" "#4A8B8B" "cyan"))         ; blue
   (pure-white  '("#e5e5e5" "#e5e5e5" "white"))        ; g_1
   (pure-black  '("#121212" "#121212" "black"))        ; background

   (highlight        white)
   (vertical-bar     base2)
   (selection        bg-alt2)
   (builtin          orange)
   (comments         base3)
   (doc-comments     fg-alt)
   (constants        magenta)
   (functions        green)
   (keywords         blue)
   (methods          green)
   (operators        base5)
   (type             blue)
   (strings          green)
   (variables        fg)
   (numbers          magenta)
   (region           base2)
   (error            red)
   (warning          yellow)
   (success          green)
   (vc-modified      orange)
   (vc-added         green)
   (vc-deleted       red)

   ;; custom categories
   (modeline-bg      bg-alt2)
   (modeline-bg-alt  bg)
   (modeline-fg      fg)
   (modeline-fg-alt  base4)

   (-modeline-pad
    (when doom-ashen-padded-modeline
      (if (integerp doom-ashen-padded-modeline) doom-ashen-padded-modeline 4))))

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
   (all-the-icons-dblue     :foreground blue)
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
   (dired-k-ignored :foreground base3)
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
   (region :background base2 :foreground fg :inverse-video nil)
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

(provide 'doom-ashen-theme)

;;; doom-ashen-theme.el ends here
