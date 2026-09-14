(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; === NAVIGATE LINES VISUALLY ===
(setq evil-respect-visual-line-mode t)
(global-visual-line-mode t)

(setq org-return-follows-link t)

(doom! :completion
       (corfu +orderless +icons); complete with cap(f), cape and a flying feather!
       (vertico +icons)  ; the search engine of the future

       :ui
       doom               ; what makes DOOM look the way it does
       hl-todo            ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       (modeline +light)  ; snazzy, Atom-inspired modeline, plus API
       tabs               ; a tab bar for Emacs
       ;;(vc-gutter +pretty); vcs diff in the fringe
       workspaces         ; tab emulation, persistence & separate workspaces
       ;;(popup)  ; tame sudden yet inevitable temporary windows

       :editor
       evil
       file-templates
       (format +onsave)
       multiple-cursors
       snippets
       word-wrap

       (undo +tree)              ; persistent, smarter undo for your inevitable mistakes
       :emacs
       (dired +icons)    ; making dired pretty [functional]
       ;;vc                ; version-control and Emacs, sitting in a tree

       :term
       ;; eshell            ; the elisp shell that works everywhere
       ;; shell             ; simple shell REPL for Emacs
       ;; term              ; basic terminal emulator for Emacs
       ;; vterm             ; the best terminal emulation in Emacs

       :checkers
                                        ; (syntax +icons
                                        ;         +flymake)              ; tasing you for every semicolon you forget
       ;;(spell +flyspell) ; tasing you for misspelling mispelling
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       ;;biblio            ; Writes a PhD for you (citation needed)
       ;;collab            ; buffers with friends
                                        ; (debugger +lsp)     ; FIXME stepping through code, to help you add bugs
       direnv
       ;;editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
                                        ; (eval +overlay)     ; run code, run (also, repls)
       (lookup 
                                        ; +dictionary
        +docsets
        +offline)   ; navigate your code and its documentation
       (lsp +peek)         ; M-x vscode
                                        ; magit               ; a git porcelain for Emacs
       ;;make              ; run make tasks from Emacs
       ;;pdf                 ; pdf enhancements
       ;;terraform         ; infrastructure as code
       tree-sitter         ; syntax and parsing, sitting in a tree...

       :lang
       typst
       ;;agda              ; types of types of types of types...
       ;;beancount         ; mind the GAAP
       ;; (cc +lsp
       ;;     +tree-sitter)   ; C > C++ == 1
       ;;clojure           ; java with a lisp
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       ;;data              ; config/data formats
       ;;(dart +flutter)   ; paint ui and not much else
       ;;dhall
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       ;;erlang            ; an elegant language for a more civilized age
       ;;ess               ; emacs speaks statistics
       ;;factor
       ;;faust             ; dsp, but you get to keep your soul
       ;;fortran           ; in FORTRAN, GOD is REAL (unless declared INTEGER)
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects and Z3
       ;;gdscript          ; the language you waited for
       ;;(go +lsp)         ; the hipster dialect
       ;;(graphql +lsp)    ; Give queries a REST
       ;;(haskell +lsp)    ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ; a language you can depend on
       ;;json              ; At least it ain't XML
       ;;janet             ; Fun fact: Janet is me!
       ;;(java +lsp)       ; the poster child for carpal tunnel syndrome
       ;;javascript        ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       ;;lean              ; for folks with too much to prove
       ;;ledger            ; be audit you can be
       ;;lua               ; one-based indices? one-based indices
       ;;nim               ; python + lisp at the speed of c
       ;;ocaml             ; an objective camel
       emacs-lisp          ; drown in parentheses
       ;; (latex +cdlatex
       ;;        +fold
       ;;        +latexmk
       ;;        +lsp)
                                        ; (markdown +grip)
                                        ; (nix +tree-sitter
                                        ;      +lsp)
       (org +dragndrop
            +pretty
            +brain
            +pandoc
            +jupyter
            +gnupot
            +present)
       ;;php               ; perl's insecure younger brother
       ;;plantuml          ; diagrams for confusing people more
       ;;graphviz          ; diagrams for confusing yourself even more
       ;;purescript        ; javascript, but functional
       ;;python            ; beautiful is better than ugly
       ;; qt                  ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       ;;raku              ; the artist formerly known as perl6
       ;;rest              ; Emacs as a REST client
       ;;rst               ; ReST in peace
       ;;(ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp
             +tree-sitter)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good
       ;;(scheme +guile)   ; a fully conniving family of lisps
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       ;;web               ; the tubes
       ;;yaml              ; JSON, but readable
       ;;zig               ; C, but simpler

       :email
       ;;(mu4e +org +gmail)
       (notmuch +org +afew)
       ;;(wanderlust +gmail)

       :app
       ;;calendar
       ;;emms
       ;;everywhere        ; *leave* Emacs!? You must be joking
       ;;irc               ; how neckbeards socialize
       ;;(rss +org)        ; emacs as an RSS reader

       :config
       literate
       (default +bindings +smartparens))
