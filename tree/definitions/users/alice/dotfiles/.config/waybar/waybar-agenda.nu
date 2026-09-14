let enum = (
  emacs -batch -l ~/.config/doom/org-agenda.el -eval '(org-batch-agenda "a")' 
  | str trim --char '"'
  | split row "\\n"
  | lines
) | enumerate

# gets first agenda item
let idx = $enum | where {|x| $x.item starts-with " "} | get 0.index

let x = $enum | skip ($idx - 1) | take 2
  | each {|e| $e.item | split words }

let a = $x.0
let b = $x.1

let weekday = $a.0 | str substring 0..2
let month = $a.2 | str substring 0..2
let DATE = [$weekday $month $a.1] | str join ' '

let ITEM = $b | str join ' ' | str substring 0..30

let FINAL = ($DATE + ': '  + $ITEM)
{text: $'($FINAL)'} | to json
