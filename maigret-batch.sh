#!/usr/bin/env bash
# ── Username source ──────────────────────────────────────────────────────────
# Priority: 1. usernames.txt (if it exists in the current folder) → 2. hard-coded fallback
usernames=()
if [ -f "usernames.txt" ]; then
    echo "[i] Reading usernames from usernames.txt ($(pwd)/usernames.txt)"
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Trim leading/trailing whitespace
        line="${line#"${line%%[![:space:]]*}"}" # remove leading
        line="${line%"${line##*[![:space:]]}"}" # remove trailing
        # Skip empty lines and lines that are (or start with) comments
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
        usernames+=("$line")
    done < "usernames.txt"
    if [ ${#usernames[@]} -eq 0 ]; then
        echo "[!] usernames.txt exists but yielded zero valid usernames → using fallback"
    fi
fi
# Only fall back if we still have nothing
if [ ${#usernames[@]} -eq 0 ]; then
    echo "[i] Using hard-coded username list"
    usernames=(
  list your usernames here 
    )
fi
echo " → Loaded ${#usernames[@]} usernames"
