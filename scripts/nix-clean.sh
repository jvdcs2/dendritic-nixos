set -e

echo "1 | emptying trash"
nix-collect-garbage -d
nix-store --gc

echo "2 | optimizing store (deduplicating)"
nix-store --optimise

echo "3 | verifying and repairing (This will take a while)"
# Checks every file hash against the DB and redownloads corrupt ones if possible
nix-store --verify --check-contents --repair

echo "4 | checking nix database integrity"
if command -v sqlite3 &> /dev/null; then
    sqlite3 /nix/var/nix/db/db.sqlite "pragma integrity_check"
else
    echo "sqlite3 not found, skipping DB integrity check."
fi

echo ">>> Maintenance Complete."
echo "when errors persist, you may need to manually delete specific paths using:"
echo "nix-store --delete /nix/store/<hash>-path"
