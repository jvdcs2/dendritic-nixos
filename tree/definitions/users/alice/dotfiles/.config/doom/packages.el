;; === DISABLE PACKAGES ===
(package! solaire-mode :disable t)
(package! treemacs :disable t)

;; --- HELPFUL PACKAGES ---
(package! drag-stuff)
(package! openwith)
(package! meow)

;; --- TOOLS ---
(package! lsp-mode)
(package! nix-mode)

;; --- EYECANDY PACKAGES ---
(package! rainbow-delimiters)
(package! spacious-padding)
(package! adaptive-wrap)
(package! centaur-tabs)
(package! dashboard)
(package! olivetti)

(package! org-typst-preview
  :recipe (:host github :repo "remimimimimi/org-typst-preview.el"))
(package! nano-calendar
  :recipe (:host github :repo "rougier/nano-calendar"))
;; (package! hel
;;   :recipe (:host github :repo "anuvyklack/hel"))

;; (use-package dash :ensure t)
;; (use-package avy :ensure t)
;; (use-package pcre2el :ensure t)

