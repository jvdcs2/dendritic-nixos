dir="$HOME/syncthing/org/main"
i=1

while [ -f "$dir/scratch${i}.org" ]; do
    ((i++))
done

touch "$dir/scratch${i}.org"

emacsclient -n -c -a "" -e "(progn (find-file \"$dir/scratch${i}.org\") (meow-insert))"
