let results = (rg --line-number --no-heading --column --color=never (input 'pattern: '))

if ($results | is-not-empty) {
    $results
    | fzf --height=50%
    | awk -F: '{print $1 ":" $2 ":" $3}'
    | xargs -r hx
} else {
    echo "No results found."
}
